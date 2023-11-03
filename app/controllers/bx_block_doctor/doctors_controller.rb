module BxBlockDoctor
	class DoctorsController < ApplicationController
		before_action :authenticate_request
		before_action :check_doctor

		def index
			#comment: remove unecessary if block, remove meta
			doctors = Doctor.all
			render json: BxBlockDoctor::DoctorSerializer.new(doctors, meta: {message: 'index action'}).serializable_hash, status: :ok if doctors
		end

		def create
			doctor = @current_account.build_doctor(doctor_params)
			if doctor.save
				render json: BxBlockDoctor::DoctorSerializer.new(doctor, meta: {message: 'Profile Created'}).serializable_hash, status: :created 
			else
				render json:  {errors: doctor.errors.full_messages }, status: :unprocessable_entity
			end
		end

		def show
			#comment: remove meta
			render json: BxBlockDoctor::DoctorSerializer.new(@current_account.doctor, meta: {message: 'Show Action'}).serializable_hash, status: :ok
		end

		def update
			if @current_account.doctor.update(doctor_params)
			render json: BxBlockDoctor::DoctorSerializer.new(@current_account.doctor, meta: {message: "profile updated"}).serializable_hash, status: :ok 
			else
				render json:  {errors: @current_account.doctor.errors.full_messages }, status: :unprocessable_entity
			end
		end

		private
		 def doctor_params
		 		params.permit(:name, :practicing_from, :professional_statement, :department_id, :start_time, :end_time)
		 end

		 def check_doctor
		 		return render json: {error: "You are not authorized"}, status: :unauthorized unless @current_account.role.eql?("doctor")
		 end
	end
end