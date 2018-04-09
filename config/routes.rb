Rails.application.routes.draw do
  get 'amazon_serchs/index'

  get 'amazon_serchs/show'

  root 'amazon_serchs#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
