class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, presence: true, uniqueness: true

  def self.create_shortened_url(long_url)
    ShortenedUrl.create(
      long_url: long_url,
      short_url: ShortenedUrl.generate_random_short_url
    )
  end

  def self.generate_random_short_url
    while(true)
      short_url = SecureRandom.urlsafe_base64(16)
      return short_url if !ShortenedUrl.exists?(short_url: short_url)
    end
  end
end
