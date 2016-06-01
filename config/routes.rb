Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/requests'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "pages#home"
end
