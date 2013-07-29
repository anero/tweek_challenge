class Like < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  validates_uniqueness_of :movie_id, :scope => :user_id
  validates_presence_of :user
  validates_presence_of :movie
end
