TrendFinderFrontend::Application.routes.draw do

  root :to => 'static_pages#index'

  resources :keywords
  resources :sessions, only: [ :create, :destroy ], :defaults => { :format => 'json' }

  get  '/about'       => 'static_pages#about'
  get  '/feedback'    => 'feedback#new'
  post '/search'      => 'search#index'

end
