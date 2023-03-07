Rails.application.routes.draw do
  post 'auth/login', to: 'auth#login'
  get 'user', to: 'users#show'
end
