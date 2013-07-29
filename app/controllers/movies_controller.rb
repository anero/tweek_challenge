class MoviesController < ApplicationController
	def create
		movie = Movie.create(params[:movie])
		render :json => movie, :status => :created
	end

	def update
		movie = Movie.find(params[:id])
		if movie
			movie.update_attributes(params[:movie])
			render :nothing => true, :status => :ok
		else
			render :nothing => true, :status => :not_found
		end
	end

	def destroy
		movie = Movie.find(params[:id])
		if movie
			movie.destroy
			render :nothing => true, :status => :ok
		else
			render :nothing => true, :status => :not_found
		end
	end
end