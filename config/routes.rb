Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#index"

  resources :books, only: [:new, :create, :index, :show,:edit, :destroy, :update]
  resources :users, only: [:index, :show, :update,:edit,:create]
  get "homes/about" => "homes#about"
  get "homes/index" => "homes#index"
end

Refile.secret_key = '4ce9854e363d2b84b8c45760fff935821c7c6ef1f5131783df89da23c4efe1957f3a8b31a7c68d66b22be1df422747d46a4f61a5adc003d8eec82dc028c60ab7'
