Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    root 'welcome#index'

   	match 'token_exchange', to: 'welcome#token_exchange', via: [:get, :post]
   	match 'access_denied',  to: 'welcome#access_denied',  via: [:get]
   	match 'access_granted', to: 'welcome#access_granted', via: [:get]
end
