Rails.application.routes.draw do

  scope :constraints => lambda{ |req| req.session[:user_type] == "admin" } do
    match '/', to: "admin/contest#index", via: :get
  end
  scope :constraints => lambda{ |req| %w(team judge).include? req.session[:user_type] } do
    match '/', to: "problem/problems#index", via: :get
  end

  root "home#index"

  get 'score_board' => 'home#score_board'

  post 'sessions' => 'sessions#create'
  delete 'session' => 'sessions#destroy'

  resources :problems, controller: 'problem/problems'
  resources :clarifications, controller: 'problem/clarifications', except: :show

  namespace :admin do
    resources :users, only: [:index, :create, :destroy]
    get 'contest' => 'contest#index'
  end

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
