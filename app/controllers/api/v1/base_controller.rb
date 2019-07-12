# frozen_string_literal: true

module Api::V1
  class BaseController < ::Api::ApplicationController
    def jsonapi_class
      Hash.new { |h, k| h[k] = "Api::V1::#{k}Serializer".safe_constantize }
    end
  end
end
