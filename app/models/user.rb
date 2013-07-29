class User < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :likes, :dependent => :destroy
  has_many :movies, :through => :likes , :uniq => true

  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$/
end
