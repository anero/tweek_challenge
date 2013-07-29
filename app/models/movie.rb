class Movie < ActiveRecord::Base
  attr_accessible :title, :year, :genres

  has_many :likes, :dependent => :destroy

  validates_numericality_of :year

  def genres_list
  	genres.nil? ? [] : genres.split(',').map { |g| g.strip }
  end
end
