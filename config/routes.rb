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

  # this is just a convenience to create a named route to rack-cas' logout
  get '/logout' => -> env { [200, { 'Content-Type' => 'text/html' }, ['Rack::CAS should have caught this']] }, as: :logout


  root to: "types#index"
end
