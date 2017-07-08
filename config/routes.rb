Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resources :shortened_urls, only: [:index, :create]
  end
end
