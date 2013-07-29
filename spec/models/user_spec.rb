require 'spec_helper'

describe User do
  context "validations" do
  	it "should validate unique email" do
			User.create(:name => 'user1', :email => 'test@example.com')

			new_user = User.new(:name => 'user2', :email => 'test@example.com')

			new_user.save.should be_false
			new_user.errors.should include(:email)
  	end

  	it "should be able to like two different movies" do
  	  gone_with_wind = Movie.new(:title => 'Gone with the wind', :year => '1939', :genres => 'drama, war')
  	  gone_with_wind.save
  	  casablanca = Movie.new(:title => 'Casablanca', :year => '1942', :genres => 'drama, war')
  	  casablanca.save
  	  user = User.new(:name => 'John Doe', :email => 'john@example.com')
  	  user.movies << gone_with_wind
  	  user.movies << casablanca


  	  user.valid?.should be_true
  	  user.movies.size.should == 2
  	end

  	it "should not be able to like the same movie more than once" do
  	  gone_with_wind = Movie.new(:title => 'Gone with the wind', :year => '1939', :genres => 'drama, war')
  	  gone_with_wind.save
  	  user = User.new(:name => 'John Doe', :email => 'john@example.com')
  	  user.movies << gone_with_wind
  	  user.movies << gone_with_wind
  	  
  	  user.movies.size.should == 1
  	end
  end

  it "should delete likes on user deleted" do
  	gone_with_wind = Movie.new(:title => 'Gone with the wind', :year => '1939', :genres => 'drama, war')
	  gone_with_wind.save
	  user = User.new(:name => 'John Doe', :email => 'john@example.com')
	  user.movies << gone_with_wind
	  user.save

	  gone_with_wind_like = user.likes[0]
	  Like.where('id = ?', gone_with_wind_like.id).should == [ gone_with_wind_like ]

	  user.destroy

	  Like.where('id = ?', gone_with_wind_like.id).should == []
  end
end
