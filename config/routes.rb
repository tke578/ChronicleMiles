Rails.application.routes.draw do

   	match 'token_exchange', to: 'welcome#token_exchange', via: [:get, :post]
   	match 'access_denied',  to: 'welcome#access_denied',  via: [:get]
   	match 'home_index', 	to: 'welcome#index', via: [:get]

   	devise_for :users, :controllers => {:sessions => 'sessions', registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks"  }

   	resources :users

   	root 'welcome#home'
end
