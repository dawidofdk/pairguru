# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre
  has_many :comments, dependent: :destroy

  delegate *Remote::Movie::ATTRIBUTES, to: :remote_movie, allow_nil: true
  validates :title, title_brackets: true

  def poster
    return unless remote_movie&.poster

    [ENV["REMOTE_MOVIE_IMAGES_URL"], remote_movie&.poster].join
  end

  private

  def remote_movie
    @remote_movie ||= Rails.cache.fetch("remote_movie/" + Digest::MD5.hexdigest(title), expires_in: 2.minutes) do
      Remote::Movie.find(id: title)
    end
  rescue Flexirest::HTTPClientException, Flexirest::HTTPServerException => e
    # TODO: implement error notifier service. (e.g. sentry)
    Rails.logger.error("API returned #{e.status} : #{e.result.message} - Title: #{title}")
    nil
  end
end
