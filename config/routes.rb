Rails.application.routes.draw do
  get 'users/show'

  get 'likes/create'

  resources :venues, only: [:show, :new, :create] do
    resources :check_ins, only: [:create]
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'welcome#index'
  get "offer" => "venues#offer"

  get "like/:venue_id" => "likes#create", as: "likes"

  resources :users do
    member do
      post :follow
      post :unfollow
    end
  end

end
