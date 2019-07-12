# frozen_string_literal: true

module Api
  module V1
    class MovieSerializer < BaseSerializer
      attributes :id,
                 :title
    end
  end
end
