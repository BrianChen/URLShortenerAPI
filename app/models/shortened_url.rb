class ShortenedUrl < ActiveRecord::Base
  validates :original_url, :slug, presence: true, uniqueness: true

  def self.create_shortened_url(original_url, slug = ShortenedUrl.generate_slug)
    ShortenedUrl.create(
      original_url: original_url,
      slug: slug
    )
  end

  def self.generate_slug
    while(true)
      slug = SecureRandom.urlsafe_base64(6)
      return slug if !ShortenedUrl.exists?(slug: slug)
    end
  end

  def self.parse_long_url

  end
end
