class Visit < ActiveRecord::Base
  validates :shortened_url_id, :visited_date, presence: true

  belongs_to :shortened_url

  def self.record_visit!(shortened_url)
    Visit.create!(shortened_url_id: shortened_url.id, visited_date: DateTime.now)
  end
end
