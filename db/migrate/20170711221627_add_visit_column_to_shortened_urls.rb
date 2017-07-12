class AddVisitColumnToShortenedUrls < ActiveRecord::Migration[5.0]
  def change
    add_column :shortened_urls, :visits, :integer
  end
end
