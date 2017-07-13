require 'rails_helper'
require 'spec_helper'

RSpec.describe Visit, type: :model do
  it "has valid factory" do
    FactoryGirl.create(:visit).should be_valid
  end

  it "is invalid without a shortened_url_id" do
    FactoryGirl.build(:visit, shortened_url_id: nil).should_not be_valid
  end

  it "is invalid without a visited_date" do
    FactoryGirl.build(:visit, visited_date: nil).should_not be_valid
  end

  describe "Self.record_visit!" do
    it "create and saves visit" do
      shortened_url = FactoryGirl.create(:ShortenedUrl)
      visit = Visit.record_visit!(shortened_url)
      db_visit = Visit.find_by_shortened_url_id(shortened_url.id)
      expect(db_visit == visit).should be_truthy
    end
  end
end
