Rails.application.routes.draw do
  get '/:slug', to: 'api/shortened_urls#show'
  namespace :api, defaults: {format: :json} do
    resources :shortened_urls, only: [:index, :create]
  end
end
