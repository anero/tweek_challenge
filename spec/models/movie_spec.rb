require 'spec_helper'

describe Movie do
  it "should validate year format" do
  	movie = Movie.new(:title => 'Gone with the wind', :genres => 'drama, war')

  	movie.year = 'not valid year'
  	movie.valid?.should be_false

  	movie.year = '1939'
  	movie.valid?.should be_true
  end

  it "should return genres as list" do
    movie = Movie.new(:title => 'Gone with the wind', :year => '1939', :genres => 'drama, war')

    movie.genres_list.count.should == 2
    movie.genres_list.should include('drama')
    movie.genres_list.should include('war')
  end

  it "should return empty list if genres is empty or nil" do
    movie = Movie.new(:title => 'Gone with the wind', :year => '1939', :genres => nil)
    
    movie.genres_list.should == []

    movie.genres = ''
    movie.genres_list.should == []
  end
end
