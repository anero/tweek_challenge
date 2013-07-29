class LikesController < ApplicationController
	before_filter :validate_params

	def create
		begin
			like = Like.new(:user_id => params[:user_id], :movie_id => params[:movie_id])
			like.save!
			render :nothing => true, :status => :created
		rescue ActiveRecord::RecordInvalid => e		
			render :nothing => true, :status => e.message =~ /blank/ ? :bad_request : :conflict
		end
	end

	def destroy
		if Like.destroy(:user_id => params[:user_id], :movie_id => params[:movie_id])
			render :nothing => true, :status => :ok
		else
			render :nothing => true, :status => :bad_request
		end
	end

protected
	def validate_params
		render :nothing => true, :status => :bad_request if params[:user_id].nil? || params[:movie_id].nil?
	end	
end