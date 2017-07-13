require 'spec_helper'
require 'rails_helper'

describe ShortenedUrl do
  it "has a valid factory" do
    FactoryGirl.create(:ShortenedUrl).should be_valid
  end

  it "is invalid without an original_url" do
    FactoryGirl.build(:ShortenedUrl, original_url: nil).should_not be_valid
  end

  it "is invalid without a slug" do
    FactoryGirl.build(:ShortenedUrl, slug: nil).should_not be_valid
  end

  it "is invalid with a duplicate slug" do
    FactoryGirl.create(:ShortenedUrl, slug: "abcde4")
    FactoryGirl.build(:ShortenedUrl, slug: "abcde4").should_not be_valid
  end

  describe "Self.create_shortened_url" do
    it "creates and saves a shortened url with random slug when no slug is provided" do
      shortened_url = ShortenedUrl.create_shortened_url("wwww.google.com")
      slug = shortened_url.slug
      db_shortened_url = ShortenedUrl.find_by_slug(slug)
      expect(shortened_url == db_shortened_url).should be_truthy
    end

    it "creates and saves a shortened url with slug that is provided" do
      shortened_url = ShortenedUrl.create_shortened_url("www.facebook.com", "mySlug")
      slug = shortened_url.slug
      db_shortened_url = ShortenedUrl.find_by_slug(slug)
      expect(shortened_url == db_shortened_url).should be_truthy
      expect(slug == "mySlug").should be_truthy
    end
  end

  describe "Self.generate_slug" do
    it "generates a random secure slug" do
      random_slug = ShortenedUrl.generate_slug
      expect(random_slug.is_a?(SecureRandom)).should be_truthy
    end
  end
end
