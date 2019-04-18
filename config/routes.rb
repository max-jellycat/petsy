Rails.application.routes.draw do
  root 'users#new'
  resources 'users', only: [:new, :create, :edit] do
    member do
      get 'confirm'
    end
  end

  resources 'passwords', only: [:new, :create, :edit, :update]

  get '/profile' => 'users#edit', as: :profile
  patch '/profile' => 'users#update'

  get '/login' => 'sessions#new', as: :new_session
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: :destroy_session
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
