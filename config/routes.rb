Rails.application.routes.draw do

  namespace :admin do
    resources :users, only: [:index, :show]
    root to: 'users#index'
  end
  resources :types, only: [:index]
  resources :exams, only: [:create, :show] do
    resources :attempts, only: [:create, :show] do
      get :complete, on: :member
    end
  end

  root to: "types#index"
end
