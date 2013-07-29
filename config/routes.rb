Tweek::Application.routes.draw do
  resource :users, :only => [:create, :update, :destroy]

  resource :movies, :only => [:create, :update, :destroy]
end
