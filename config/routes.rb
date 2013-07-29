Tweek::Application.routes.draw do
  resources :users, :only => [:create, :update, :destroy]

  resources :movies, :only => [:create, :update, :destroy]

  resource :likes, :only => [:create, :destroy] 
end
