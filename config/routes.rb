CleanTweets::Application.routes.draw do
  # get "fav_tweets/index"
  # get "fav_tweets/new"
  # get "fav_tweets/destroy"
  # get "users" => "users#index" 
  # get "users/new" => "users#new"
  # post "users" => "users#create"
  # get "users/:id/edit" => "users#edit", as: 'edit_user'
  # ##will not work if I name the route "update_user". Why?
  # patch "users/:id" => "users#update", as: 'user'
  # delete "users/:id" => "users#destroy", as: 'delete_user'

  root to: 'users#new'
  resources :users, only:[:index,:new,:create,:edit,:destroy,:update]
  get "users/stream" => "users#stream", as: "stream_user"

  resources :fav_tweets, only:[:index, :new, :destroy]
  get "auth/twitter" => "fav_tweets#show_tweets", as: "twitter_auth"
  get "fav_tweets/show_tweets" => "fav_tweets#show_tweets", as: "show_tweets"
  post "fav_tweets" => "fav_tweets#create", as: "create_fav_tweet"
  get "fav_tweets/display" => "fav_tweets#display", as: "display_fav_tweet"
  get "fav_tweets/favorites" => "fav_tweets#favorites", as: "favorites_fav_tweet"
  delete "fav_tweets/favorites/:tweet_id" => "fav_tweets#delete_favorite", as: "delete_favorite"

  
  delete "auths" => "auths#destroy", as: "auths"
  resources :auths, only:[:new, :create]


  match "/auth/twitter/callback" => "fav_tweets#get_user_data", via: [:get, :post]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
