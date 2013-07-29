class UsersController < ApplicationController
	def create
		status = :created
		begin
			user = User.new(params[:user])
			user.save!

			render :json => user, :status => :created
		rescue ActiveRecord::RecordInvalid => e
			render :nothing => true, :status => :conflict
		end
	end

	def update
		status = :ok
		user = User.find(params[:id])
		if user
			if !user.update_attributes(params[:user])
				status = :bad_request
			end
		else
			status = :not_found
		end

		render :nothing => true, :status => status
	end

	def destroy
		user = User.find(params[:id])
		if user
			user.destroy(params[:user])
			render :nothing => true, :status => :ok
		else
			render :nothing => true, :status => :not_found
		end
	end
end