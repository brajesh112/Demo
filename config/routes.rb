Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :account_block do
 		resources :accounts	
 	end
 	namespace :authentication_block do
 		post "/login", to: "authentications#login"
 	end
end
