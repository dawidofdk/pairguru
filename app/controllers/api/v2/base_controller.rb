# frozen_string_literal: true

module Api::V2
  class BaseController < ::Api::ApplicationController
    def jsonapi_class
      Hash.new { |h, k| h[k] = "Api::V2::#{k}Serializer".safe_constantize }
    end

    def jsonapi_object
      { version: '2.0' }
    end
  end
end
