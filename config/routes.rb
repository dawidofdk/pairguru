Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    get :movies, on: :member
  end
  resources :movies, only: [:index, :show] do
    get :send_info, on: :member
    get :export, on: :collection
    resources :comments, only: %i[create destroy]
  end
  get :top_10_commenters, to: "comments#top_10_commenters"

  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show]
    end

    namespace :v2 do
      resources :movies, only: %i[index show]
    end
  end
end
