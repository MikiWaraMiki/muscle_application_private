Rails.application.routes.draw do
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers:{
        sessions: 'api/auth/sessions'
      }
      post 'user/follow' => "user#follow"
      delete 'user/unfollow' => "user#unfollow"
      get 'user/graph/pie' => "user#pie"
      get 'user/graph/lineweight' => "user#line_weight"
      get 'user/graph/linecount' => "user#line_count"
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
  get 'user/edit' => "muscle#index"
end
