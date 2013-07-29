class User < ActiveRecord::Base
  attr_accessible :email, :name

  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$/
end
