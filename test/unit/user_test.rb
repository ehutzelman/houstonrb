require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_validate_presence_of :identity_url, :name, :email
  
  context "A user being saved" do
    setup do
      @user = Factory :user, :identity_url => 'example.myopenid.com'
    end

    should "have their open ID url normalized" do
      assert_match /^http:\/\//, @user.identity_url
    end
  end
  
  context "An existing user with an open ID url" do
    setup do
      Factory :user, :identity_url => 'example.myopenid.com'
    end
    
    should "not allow a new user with the same open ID url" do
      user = Factory.build(:user, :identity_url => 'example.myopenid.com')
      assert !user.save
      assert !user.errors[:identity_url].nil?
    end
  end
  
end
