class ChangeUniquenessInShortenedUrls < ActiveRecord::Migration[5.0]
  def change
    remove_index :shortened_urls, :original_url
  end
end
