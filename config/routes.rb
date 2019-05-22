Rails.application.routes.draw do
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers:{
        sessions: 'api/auth/sessions'
      }
      get 'api/user/task' => "api/user#todo_all", as:"user_todo"
      resources :user
      resources :todo
      resources :post
    end
  end
  root :to =>  "muscle#index"
  get 'contact' => "muscle#index"
  get 'timeline'=> "muscle#index"
  get 'signup'  => "muscle#index"
  get 'signin'  => "muscle#index"
  get 'user'    => "muscle#index"
end
