Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :account_block do
 		resources :accounts	
 		post "/specializations", to: "accounts#specialization"
 	end

 	namespace :bx_block_doctor do
 		resources :doctors
 	end

 	namespace :bx_block_coach do
 		resources :coaches
 		resources :coach_sessions
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

 	namespace :bx_block_appointment do
 		resources :appointments
 		get "/accounts", to: "appointments#account" 
 		get "/slots", to: "appointments#available_slot"
 	end


 	namespace :authentication_block do
 		post "/login", to: "authentications#login"
 	end
end
