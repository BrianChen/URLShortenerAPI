require 'spec_helper'
require 'rails_helper'

RSpec.describe Api::ShortenedUrlsController, type: :controller do
  before(:each) do
    @shortened_url = FactoryGirl.create(:ShortenedUrl)
    @shortened_url_id = @shortened_url.id
    @shortened_url_original_url = @shortened_url.original_url
    @shortened_url_slug = @shortened_url.slug
  end
  describe "GET #index" do
    it "populates an array with all shortened urls" do
      get :index
      assigns(:shortened_urls).should eq([@shortened_url])
    end
  end

  describe "GET #show" do
    it "redirects to that shortened url" do
      get :show, slug: @shortened_url_slug
      expect(response).to redirect_to(@shortened_url_original_url)
    end

    it "renders an message if the link is not found" do
      message = "Uh oh, couldn't find a link for the URL you clicked"
      get :show, slug: "thisUrlDoesNotExist"
      expect(response.body).to eq(message)
    end
  end

  describe "POST #create" do
    it "response with a status 422 if url params is invalid" do
      message = "Invalid url: http or https accepted"
      post :create, original_url: "notAValidUrl"
      expect(response.status).to be(422)
      expect(response.body).to eq(message)
    end

    it "response with a status 422 if slug provided already exist and not save to database" do
      message = "Slug already used, please try another"
      post :create, {original_url:"https://www.google.com", slug:@shortened_url_slug}
      expect(response.body).to eq(message)
      expect(response.status).to be(422)
    end

    it "creates a new shortened url with provided slug if slug does not already exist" do
      post :create, {original_url: "http://www.google.com", slug:"slugDoesNotExist"}
      expect(ShortenedUrl.last.slug).to eq("slugDoesNotExist")
    end
  end
end
