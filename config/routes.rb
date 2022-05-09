Rails.application.routes.draw do

  devise_for :users
  root "main#index"

  get "/add-customer", to: "main#create"
  post "/add-customer", to: "main#create"
  get "/show-customer/:id", to: "main#show"



  
  


  
end
