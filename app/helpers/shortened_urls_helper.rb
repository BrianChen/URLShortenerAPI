require 'uri'

module ShortenedUrlsHelper
  def is_valid_url?(original_url)
    uri = URI.parse(original_url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  # def is_valid_slug?(slug)
  #   if slug && ShortenedUrl.exists?(slug: slug)
  #     return "slug"
  #
  # end
end
