require 'faker'

FactoryGirl.define do
  factory :visit do |f|
    association :shortened_url, factory: :ShortenedUrl
    f.visited_date {DateTime.now}
  end
end
