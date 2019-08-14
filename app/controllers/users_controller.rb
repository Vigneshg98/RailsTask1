class UsersController < ApplicationController

	#require_relative '../modules/testmodule'
	#include TestModule

    before_action :checkSession, :only => [:display, :show]

	def index
	end

	def landing
		session[:user_id] = nil
		session[:last_visited_path] = nil
		@user = User.new
	end

	def display
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			ExampleMailer.sample_email(@user).deliver_now
			redirect_to users_path
		else
			render 'new'
		end
	end

	def validate
		if session[:user_id] == nil	
			xname = params[:user][:username]
			xpass = params[:user][:password]
			@user = Methods.new.crossCheck(xname, xpass).first
		end
		if @user.present?
			session[:user_id] = @user.id
			session[:last_visited_path] = request.original_url
			#redirect_to 'display_path'
			render 'display'
		else
			if session[:user_id] == nil
				flash[:danger] = "....."
				redirect_to landing_path
			else
				@user = User.where(id: session[:user_id]).select("*").first
				render 'display'
			end
		end
	end

	def display
		#format.html { redirect_to(display_path) }
	end

	def logout
		session[:user_id] = nil
		session[:last_visited_path] = nil   
    	redirect_to users_path, notice: 'Logged out!' 
	end

	

	private

  		def user_params
    		params.require(:user).permit(:username, :surname, :password, :email, :role)
 		end

 		def checkSession			
			if session[:user_id].present?
				redirect_to session[:last_visited_path]
			else
				redirect_to landing_path
			end
		end

end
