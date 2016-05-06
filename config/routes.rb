Rails.application.routes.draw do


  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  resources :users
  resource :session
  resources :subs
  resources :posts
  # resources :
end
