class ChangeShortenedUrlsColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :shortened_urls, :short_url, :slug
    rename_column :shortened_urls, :long_url, :original_url
  end
end
