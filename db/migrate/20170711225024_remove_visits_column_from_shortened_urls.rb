class RemoveVisitsColumnFromShortenedUrls < ActiveRecord::Migration[5.0]
  def change
    remove_column :shortened_urls, :visits
  end
end
