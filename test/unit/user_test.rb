require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_validate_presence_of :identity_url, :name, :email
  
  context "A user being saved with an unformatted URL" do
    setup do
      @user = Factory :user, :url => 'example.myopenid.com'
    end

    should "have their url normalized" do
      assert_match /^http/i, @user.url
    end
  end
  
  context "An existing user with an open ID url" do
    setup do
      @user = Factory :user, :identity_url => 'example.myopenid.com'
    end
    
    should "not allow a new user with the same open ID url" do
      user = Factory.build(:user, :identity_url => 'example.myopenid.com')
      assert !user.save
      assert !user.errors[:identity_url].nil?
    end    
  end
  
  context "A user who has opted in for display and has a bio" do
    setup do
      @user = Factory :user, :display => true, :bio => 'about me'
    end
    
    should "return a gravatar for the image_url" do
      assert_match /gravatar/, @user.image_url
    end

    should "be returned for User#random" do
      assert_equal @user, User.random
    end
    
    should "be included in the displayable named scope" do
      assert_equal @user, User.displayable.first
    end
  end
  
end
