class Api::ShortenedUrlsController < ApplicationController
  include ShortenedUrlsHelper

  def index
    @shortened_urls = ShortenedUrl.all
    render json: @shortened_urls
  end

  def show
    @shortened_url = ShortenedUrl.find_by_slug(params[:slug])
    if @shortened_url
      Visit.record_visit!(@shortened_url)
      redirect_to @shortened_url.original_url
    else
      render json: "Uh oh, couldn't find a link for the URL you clicked"
    end
  end

  def create
    if !is_valid_url?(params[:original_url])
      render json: "Invalid url: http or https accepted", status: 422
    else
      if params[:slug]
        if ShortenedUrl.exists?(slug: params[:slug])
          render json: "Slug already used, please try another", status: 422
        else
          @shortened_url = ShortenedUrl.create_shortened_url(params[:original_url], params[:slug])
          res = {original_url: @shortened_url.original_url, short_url: "http://localhost:3000/" + @shortened_url.slug }
          render json: res
        end
      else
        @shortened_url = ShortenedUrl.create_shortened_url(params[:original_url])
        res = {original_url: @shortened_url.original_url, short_url: "http://localhost:3000/" + @shortened_url.slug }
        render json: res
      end
    end
  end
end
