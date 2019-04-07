Rails.application.routes.draw do
  get 'todos/new'
  get 'todos/create'
  resources :users, only: [:show]
  resources :todos
  devise_for :user,  skip: :all
  devise_scope :user do
    get 'login' => 'users/sessions#new', as: :new_user_session
    post 'login' => 'users/sessions#create', as: :user_session
    get 'logout' => 'users/sessions#destroy', as: :destroy_user_session
    get 'signup' => 'users/registrations#new', as: :new_user_registration
    post 'signup' => 'users/registrations#create', as: :user_registration
    get 'signup/cancel' => 'users/registrations#cancel', as: :cancel_user_registration
    get 'user' => 'users/registrations#edit', as: :edit_user_registration
    patch 'user' => 'users/registrations#update', as: nil
    put 'user' => 'users/registrations#update', as: :update_user_registration
    delete 'user' => 'users/registrations#destroy', as: :destroy_user_registration
    get 'password' => 'users/passwords#new', as: :new_user_password
    post 'password' => 'users/passwords#create', as: :user_password
    get 'password/edit' => 'users/passwords#edit', as: :edit_user_password
    patch 'password' => 'users/passwords#update'
    put 'password' => 'users/passwords#update', as: :update_user_password
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  root "muscle#index"
end
