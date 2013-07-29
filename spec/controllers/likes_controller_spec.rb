require 'spec_helper'

describe LikesController do
	context "create like" do
		let(:gone_with_wind) { Movie.create(:title => 'Gone with the wind', :year => '1939', :genres => 'drama, war') }
		let(:john_doe) { User.create(:name => 'John Doe', :email => 'john@example.com') }

		it "should create a new like" do
			like_double = double
			Like.should_receive(:new).with(:user_id => john_doe.id.to_s, :movie_id => gone_with_wind.id.to_s).and_return(like_double)
			like_double.should_receive(:save!).and_return(true)

		  post :create, :user_id => john_doe.id, :movie_id => gone_with_wind.id

		  response.status.should == 201
		end

		it "should return status 400 (Bad Request) if user_id not provided" do
		  post :create, :movie_id => 100

		  response.status.should == 400
		end

		it "should return status 400 (Bad Request) if movie_id not provided" do
		  post :create, :user_id => 1

		  response.status.should == 400
		end

		it "should return status 400 (Bad Request) if user not found" do
		  post :create, :user_id => 99999, :movie_id => gone_with_wind.id

		  response.status.should == 400
		end

		it "should return status 400 (Bad Request) if movie not found" do
		  post :create, :user_id => john_doe.id, :movie_id => 99999

		  response.status.should == 400
		end

		it "should return status 409 (Conflict) if user already liked movie" do
		  Like.create(:user => john_doe, :movie => gone_with_wind)

		  post :create, :user_id => john_doe.id, :movie_id => gone_with_wind.id

		  response.status.should == 409
		end
	end

	context "delete like" do
	  it "should delete existing like" do
	    Like.should_receive(:destroy).with(:user_id => '1', :movie_id => '99').and_return(true)

	    delete :destroy, :user_id => 1, :movie_id => 99

	    response.status.should == 200
	  end

	  it "should return status 400 (Bad Request) if user_id not provided" do
		  delete :destroy, :movie_id => 100

		  response.status.should == 400
		end

		it "should return status 400 (Bad Request) if movie_id not provided" do
		  delete :destroy, :user_id => 1

		  response.status.should == 400
		end

	  it "should return status 400 (Bad Request) if like cannot be found" do
	    Like.should_receive(:destroy).with(:user_id => '1', :movie_id => '99').and_return(false)

	    delete :destroy, :user_id => 1, :movie_id => 99

	    response.status.should == 400
	  end
	end
end