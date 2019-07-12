# frozen_string_literal: true

module Api
  module V2
    class GenreSerializer < BaseSerializer
      attributes :id,
                 :name

      attribute :number_of_movies do
        @object.movies.count
      end

      belongs_to :movie
    end
  end
end
