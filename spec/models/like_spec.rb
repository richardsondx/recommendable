require 'spec_helper'

class LikeSpec < MiniTest::Spec
  describe Recommendable::Like do
    before :each do
      @user = User.create(:username => "dave")
    end
    
    it "should not be created for an object that does not act_as_recommendedable" do
      cake = PhpFramework.create(:name => "CakePHP")
      proc { @user.like(cake) }.must_raise Recommendable::RecordNotRecommendableError
    end
    
    it "should be created for an object that does act_as_recommendable" do
      movie = Movie.create(:title => "2001: A Space Odyssey", :year => 1968)
      
      @user.like(movie).must_equal true
    end
    
    it "should not be created twice for the same user-object pair" do
      movie = Movie.create(:title => "2001: A Space Odyssey", :year => 1968)
      
      @user.like(movie).must_equal true
      @user.like(movie).must_be_nil
      Recommendable::Like.count.must_equal 1
    end
  end
end