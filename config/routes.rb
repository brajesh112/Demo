Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :account_block do
 		resources :accounts	
 	end

 	namespace :bx_block_doctor do
 		resources :doctors
 	end

 	namespace :bx_block_coache do
 		resources :coaches
 	end

 	namespace :bx_block_patient do
 		resources :patients
 	end

 	namespace :bx_block_deparment do
 		resources :deparments
 	end

 	namespace :bx_block_specialization do
 		resources :specializations
 	end


 	namespace :authentication_block do
 		post "/login", to: "authentications#login"
 	end
end
