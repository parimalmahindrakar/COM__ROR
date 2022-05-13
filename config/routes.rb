Rails.application.routes.draw do

  devise_for :users

  
  # for Customers
  # ===================================
  root "customers#index"
  get "/add-customer", to: "customers#new"
  post "/add-customer", to: "customers#create"
  get "/show-customer/:id", to: "customers#show"
  get "/update-customer/:id", to: "customers#edit"
  post "/update-customer", to: "customers#update"
  delete "/delete-customer/", to: "customers#delete"


  # for Products
  # ===================================

  get "/products", to: "products#index"
  get "/add-product", to:"products#new"
  post "/add-product", to:"products#create"
  delete "/delete-product", to: "products#delete"
  get "/update-product", to: "products#edit"
  post "/update-product", to: "products#update"

  
  # for Orders
  # ===================================
  get "/orders", to: "orders#index"
  get "/add-order", to: "orders#new"
  post "/add-order", to: "orders#create"





  
  


  
end
