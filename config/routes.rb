Tapski::Application.routes.draw do
  root :to => "home#index"


  resources :listings do
    member do
      post 'rename'
    end
  end

  #root :to => "listings#index"
  resources :identities
  match '/save_search', :to => "home#save_search"
  match '/mysearches', :to => "home#mysearches"
  match '/search_with_criteria', :to => "home#search_with_criteria"
  match '/get_search_details', :to => "home#get_search_details"
  match '/mylistings', :to => "listings#index"
  match '/profile', :to => "users#profile"
  resources :users
  match "/save_profile", :to => "users#save_profile"
  match "/login", :to => "sessions#new"
  match "/signout" => "sessions#destroy", :as => :signout
  match '/auth/:provider/callback',  to: 'sessions#create'
  match "/auth/failure", to: "sessions#failure"
  match '/auth/:provider/register',  to: 'users#create'
  match '/edit' =>  'users#edit_profile'
  match '/homesearch' => 'listings#home_search'
  match '/my_search_listing' => 'listings#my_search_listing'

  match '/get_listing_contact' => 'listings#get_contact'
  match '/show_image' => 'listings#show_image'
  match '/add_images' => 'listings#add_images'
  match '/upload_image' => 'listings#upload_image', :via => :post
  match '/messages' => 'users#messages'
  match '/reply_message' => 'users#reply_message'
  match '/send_message' => 'users#send_message'
  match '/delete_message' => 'users#delete_message'
  match '/vote_listing' => 'listings#vote_up'
  match '/remove_vote_listing' => 'listings#vote_remove'
  resources :mysearches
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
