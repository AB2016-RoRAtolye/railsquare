Rails.application.routes.draw do
  resources :venues, only: [:show, :new, :create] do
    resources :check_ins, only: [:create]
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'welcome#index'
end
