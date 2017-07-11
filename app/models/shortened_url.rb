class ShortenedUrl < ActiveRecord::Base
  validates :original_url, :visits, presence: true
  validates :slug, uniqueness: true, presence: true

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
end
