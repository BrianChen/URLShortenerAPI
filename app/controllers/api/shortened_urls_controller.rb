class Api::ShortenedUrlsController < ApplicationController

  def index
    @shortened_urls = ShortenedUrl.all
    render json: @shortened_urls
  end

  def create
    @shortened_url = ShortenedUrl.create_shortened_url(params[:long_url])
    render json: @shortened_url
  end

  # private
  # def shortened_url_params
  #   params.require(:shortened_url)
  # end
end
