# frozen_string_literal: true

module Api
  class BaseSerializer < JSONAPI::Serializable::Resource
    extend JSONAPI::Serializable::Resource::ConditionalFields
    extend JSONAPI::Serializable::Resource::KeyFormat

    key_format ->(key) { key.to_s.camelize(:lower) }
    type { @object.class.name.pluralize.camelize(:lower) }
  end
end
