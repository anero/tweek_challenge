require 'spec_helper'

describe MoviesController do
	context "create movie" do
		it "should create a new movie" do
			Movie.find_by_title('Gone with the wind').should be_nil

		  post :create, :movie => { :title => 'Gone with the wind', :year => '1939', :genres => 'drama, war' }

		  response.status.should == 201
		  created_movie = Movie.find_by_title('Gone with the wind')
		  created_movie.should_not be_nil
		  response.body.should == created_movie.to_json
		end
	end

	context "update movie" do
	  it "should update existing movie" do
	    movie_double = double(:id => 100)
			movie_double.should_receive(:update_attributes).with('title' => 'Gone with the wind 2 - The comeback', 'year' => '1958', 'genres' => 'comedy').and_return(true)
			Movie.should_receive(:find).with('100').and_return(movie_double)
		  
		  put :update, :id => 100, :movie => { :title => 'Gone with the wind 2 - The comeback', :year => '1958', :genres => 'comedy' }

		  response.status.should == 200
	  end

	  it "should return status 404 (Not Found) if movie cannot be found" do
	    Movie.should_receive(:find).with('100').and_return(nil)
		  
		  put :update, :id => 100, :movie => { :title => 'Gone with the wind 2 - The comeback', :year => '1958', :genres => 'comedy' }

		  response.status.should == 404
	  end
	end

	context "delete movie" do
	  it "should delete existing movie" do
	    movie_double = double(:id => 100)
			movie_double.should_receive(:destroy)
			Movie.should_receive(:find).with('100').and_return(movie_double)
		  
		  delete :destroy, :id => 100

		  response.status.should == 200
	  end

	  it "should return status 404 (Not Found) if movie cannot be found" do
	    Movie.should_receive(:find).with('100').and_return(nil)
		  
		  delete :destroy, :id => 100

		  response.status.should == 404
	  end
	end
end