require 'spec_helper'

describe UsersController do
	context "create user" do
		it "should create a new user" do
			User.find_by_email('john@example.com').should be_nil

		  post :create, :user => { :name => 'John Doe', :email => 'john@example.com' }

		  response.status.should == 201
		  created_user = User.find_by_email('john@example.com')
		  created_user.should_not be_nil
		  response.body.should == created_user.to_json
		end

		it "should return status 409 (Conflict) if user cannot be created because user with given email already exists" do
			user_double = double(:errors => double(:full_messages => ['Validation failed: Email has already been taken']))
			User.should_receive(:new).with('name' => 'John Doe 2', 'email' => 'john@example.com').and_return(user_double)
			user_double.should_receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(user_double))

		  post :create, :user => { :name => 'John Doe 2', :email => 'john@example.com' }

		  response.status.should == 409
		end  
	end
	
	context "update user" do
		it "should update existing user" do
			user_double = double(:id => 999)
			user_double.should_receive(:update_attributes).with('email' => 'john@example.com', 'name' => 'Jane Doe').and_return(true)
			User.should_receive(:find).with('999').and_return(user_double)
		  
		  put :update, :id => 999, :user => { :email => 'john@example.com', :name => 'Jane Doe' }

		  response.status.should == 200
		end

		it "should return status 404 (Not Found) if user cannot be found" do
			User.should_receive(:find).with('999').and_return(nil)
		  
		  put :update, :id => 999, :user => { :email => 'john@example.com', :name => 'Jane Doe' }

		  response.status.should == 404
		end

		it "should return status 400 (Bad Request) if user cannot be udpated" do
		  user_double = double(:id => 999)
			user_double.should_receive(:update_attributes).with('email' => 'john@example.com', 'name' => 'Jane Doe').and_return(false)
			User.should_receive(:find).with('999').and_return(user_double)
		  
		  put :update, :id => 999, :user => { :email => 'john@example.com', :name => 'Jane Doe' }

		  response.status.should == 400
		end
	end

	context "delete user" do
	  it "should delete existing user" do
	    user_double = double(:id => 999)
			user_double.should_receive(:destroy)
			User.should_receive(:find).with('999').and_return(user_double)
		  
		  delete :destroy, :id => 999

		  response.status.should == 200
	  end

	  it "should return status 404 (Not Found) if user cannot be found" do
	    User.should_receive(:find).with('999').and_return(nil)
		  
		  delete :destroy, :id => 999

		  response.status.should == 404
	  end
	end
end