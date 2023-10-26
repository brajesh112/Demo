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

 	namespace :bx_block_conversation do
 		resources :conversations
 		post "/send_message", to: "conversations#send_message"
 		get "/select_doc", to: "conversations#select_doc"
 	end

 	namespace :bx_block_appointment do
 		resources :appointments
 		get "/accounts", to: "appointments#account" 
 		get "/slots", to: "appointments#available_slot"
 	end

 	namespace :bx_block_session do
 		resources :coach_sessions
		resources :patient_coach_sessions
 		get "/show_coach", to: "patient_coach_sessions#show_coach"
 		get "/available_sessions", to: "patient_coach_sessions#available_sessions"
 		get "/coach_session_id", to: "patient_coach_sessions#coach_session_id"
	end

 	
 	namespace :authentication_block do
 		post "/login", to: "authentications#login"
 	end
end
