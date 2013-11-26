ProjectHelp::Application.routes.draw do
  post "topics/search"        => 'topics#search'
  get "topics/:id(.:format)"  => 'topics#show'
  get "network/"               => 'home#dashboard'
  resources :messages, only: [:create]
  
  resources :conversations, only: [:create, :update]
  get "inbox/:id(.:format)"   => 'conversations#show'
  get "inbox/"                => 'conversations#index'
  
  get "groups/:id(.:format)"  => 'groups#show'
  get "welcome/index"
  get "welcome/introduction"  => 'welcome#introduction'

  #Additional routes for Users for part 2 of registration and the admin panel
  get '/users/:id/new2' =>  'users#new2'
  get '/users/admin' => 'users#admin_panel'

  #Basic routes for users
  resources :users 

  #Basic routes for Posts and Comments, but only create, update and destroy
  resources :posts, only: [:create, :update, :destroy]
  resources :comments, only: [:create, :update, :destroy]

  #Routes for logging in and logging out
  post "sessions/create" => 'sessions#create'
  get "sessions/destroy"

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  

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
