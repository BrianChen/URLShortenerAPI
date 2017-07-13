require 'faker'

FactoryGirl.define do
  factory :ShortenedUrl do |f|
    f.original_url { Faker::Internet.url }
    f.slug { Faker::Code.ean(6)}
  end
end
