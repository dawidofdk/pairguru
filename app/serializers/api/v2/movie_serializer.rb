# frozen_string_literal: true

module Api
  module V2
    class MovieSerializer < BaseSerializer
      attributes :id,
                 :title

      belongs_to :genre
    end
  end
end
