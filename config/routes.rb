Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    get :movies, on: :member
  end
  resources :movies, only: [:index, :show] do
    get :send_info, on: :member
    get :export, on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :movies, only: %i[index show]
    end
  end
end
