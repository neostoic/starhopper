Rails.application.routes.draw do

  # Devise route to allow custom fields in signup/edit forms
  devise_for :users, :controllers => { 
    :registrations =>  'registrations',
    # :sessions => 'sessions',
    :passwords => 'passwords',
    :omniauth_callbacks => 'callbacks' }

    # Authenticated user will be redirected to map.  A landing page, describing the service is shown if not
    authenticated :user do
      root :to => "welcome#map", as: :authenticated_root
    end
    root :to => 'welcome#index'

    resources :users do
      resources :chats, :controller => "user_chats"
    end

    resources :chats, :controller => "user_chats" do
      resources :messages
      member do
        post :mark_as_read
        post :mark_as_unread
      end
    end

    # MESSAGES ROUTES
    # get 'messages/index'
    # get 'messages/new'
    # get 'messages/create'
    # get 'messages/show'
    # get 'messages/edit'
    # get 'messages/update'
    # get 'messages/destroy'

    # FAVORITES ROUTES
    get 'favorites/index'
    get 'favorites/create'
    post 'favorites/create'
    get 'favorites/show'
    get 'favorites/update'
    get 'favorites/destroy'

    # PROFILES ROUTES
    get 'profiles/index'
    get 'profiles/show'
    get 'profiles/new'
    get 'profiles/create'
    get 'profiles/edit'
    get 'profiles/update'
    get 'profiles/destroy'


    # resources :users

  #Contact Page and Sendmail route
  get 'contact' => 'welcome#contact'
  post 'welcome/sendmail'

  # Profiles route to pass user id in
  get "profiles/:id", :controller => "profiles", :action => "index", as: :profile

  # User Registration Routes
  # devise_scope :user do
  #   get "/register" => "devise/registrations#new"
  # end

  get '/' => 'welcome#index'
  get 'map' => "welcome#map"

  # Map new search
  post '/welcome', to: 'welcome#create'




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
