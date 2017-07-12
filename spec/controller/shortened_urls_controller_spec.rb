require 'spec_helper'

describe ShortenedUrlsControllerSpec do
  describe "GET #index" do
    it "populates an array with all shortened urls"
    it "responds with the array of shortened urls in json format"
  end

  describe "GET #show" do
    it "redirects to that shortened"
    it "records a visit"
    it "renders an error if the link is not found"
  end

  describe "POST #create" do
    it "renders an error if url params is invalid"
    it "renders an error if slug provided already exist"
    it "creates a new shortened url with provided slug if slug does not already exist"
    it "creates a new shortened url with random slug if no slug provided"
  end
end
