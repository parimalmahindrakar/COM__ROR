Rails.application.routes.draw do

  devise_for :users
  
  root "main#index"
  get "/add-customer", to: "main#new"
  post "/add-customer", to: "main#create"
  get "/show-customer/:id", to: "main#show"





  get "/update-customer/:id", to: "main#edit"
  post "/update-customer", to: "main#update"
  delete "/delete-customer/", to: "main#destroy"







  
  


  
end
