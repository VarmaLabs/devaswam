Rails.application.routes.draw do

  namespace(:trust_admin){ resources :offerings }
  root :to => 'welcome#index'

  namespace(:super_admin){
    resources :trust_admins
    resources :trusts
    resources :temples
    resources :deities
  }

  namespace(:trust_admin){
    resources :deities do
      resources :offerings
    end
  }

  # Sign In URLs for super admin users
  get     'super_admin/sign_in'         => "super_admin/sessions#sign_in",         :as => :super_admin_sign_in
  post    'super_admin/create_session'  => "super_admin/sessions#create_session",  :as => :super_admin_create_session
  delete  'super_admin/sign_out'        => "super_admin/sessions#sign_out",        :as => :super_admin_sign_out

  get     'super_admin/home'           => "super_admin/home#index",                :as => :super_admin_home

  # Sign In URLs for trust admin users
  get     'trust_admin/sign_in'         => "trust_admin/sessions#sign_in",         :as => :trust_admin_sign_in
  post    'trust_admin/create_session'  => "trust_admin/sessions#create_session",  :as => :trust_admin_create_session
  delete  'trust_admin/sign_out'        => "trust_admin/sessions#sign_out",        :as => :trust_admin_sign_out

  get     'trust_admin/home'           => "trust_admin/home#index",                :as => :trust_admin_home

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
