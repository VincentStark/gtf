TrendFinderFrontend::Application.routes.draw do

  root :to => 'static_pages#index'

  match '/about'       => 'static_pages#about'
  match '/feedback'    => 'feedbacks#new', :as => 'feedback', :via => :get
  match '/feedback'    => 'feedbacks#create', :as => 'feedback', :via => :post

  match '/words'       => 'entities#index_words'
  match '/sites'       => 'entities#index_sites'

  match '/words'       => 'entities#create_words', :defaults => { :format => 'json' }, :via => :post
  match '/sites'       => 'entities#create_sites', :defaults => { :format => 'json' }, :via => :post

  match '/words/:name' => 'entities#show_word', :constraints => { :name => /.*/ }
  match '/sites/:name' => 'entities#show_site', :constraints => { :name => /.*/ }

  post '/search'        => 'search#index'

  # JSON API Calls
  resources :sessions, only: [ :create, :destroy ], :defaults => { :format => 'json' }

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
