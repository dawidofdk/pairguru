# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
      responds_with_resource(resolve_model.order(:id).all)
    end

    def show
      responds_with_resource(find_record)
    end

    private

    def not_found
      responds_with_errors("Record not found", status: :not_found)
    end

    def responds_with_resource(resource, status: 200, meta: nil)
      render jsonapi: resource, status: status, meta: camelize_meta(meta)
    end

    def responds_with_errors(message, status:)
      render jsonapi_errors: error(message), status: status
    end

    def resolve_model
      controller_name.classify.constantize
    end

    def camelize_meta(meta)
      meta&.deep_transform_keys { |key| key.to_s.camelize(:lower) }
    end

    def find_record
      resolve_model.find(params[:id])
    end

    def error(message = nil)
      ActionError.new(message: message).errors
    end
  end
end
