Swimlog::Application.routes.draw do

  devise_for :users, :path_names => { :sign_up => "signup", :sign_in => "login", :sign_out => "logout" }
  #resources :items
  resources :comments
  resources :posts

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  root :to => "posts#index"

end

