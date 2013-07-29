require 'spec_helper'

describe User do
  context "validations" do
  	it "should validate unique email" do
			User.create(:name => 'user1', :email => 'test@example.com')

			new_user = User.new(:name => 'user2', :email => 'test@example.com')

			new_user.save.should be_false
			new_user.errors.should include(:email)
  	end    
  end
end
