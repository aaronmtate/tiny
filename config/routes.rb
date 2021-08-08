Rails.application.routes.draw do
  resources :url_aliases, param: :alias
  get '/:alias', to: "url_aliases#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
