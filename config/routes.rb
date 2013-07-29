Tweek::Application.routes.draw do
  resources :users, :only => [:create, :update, :destroy]
end
