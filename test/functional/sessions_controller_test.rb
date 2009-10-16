require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  context "an existing user with valid openID signs in" do
    setup do
      @user = Factory :user, :identity_url => 'http://my.openid.com'
      mock_open_id_authentication(@user.identity_url, :authenticate => true)
      post :create, :openid_url => @user.identity_url
    end
    
    should_redirect_to("the home page") { root_url }
    should_set_session(:user_id) { @user.id }
    should_set_the_flash_to /signed in/i
  end
  
  context "a new user with a valid openID signs in" do
    setup do
      @identity_url = 'http://my.openid.com'
      mock_open_id_authentication(@identity_url, :authenticate => true)
      post :create, :openid_url => @identity_url
    end    

    should_redirect_to("the new user page") { new_user_url }

    should "store the new user in flash" do
      assert flash[:user].class == User
    end

    should "populate flash user with openID attributes" do
      assert_equal @identity_url, flash[:user].identity_url
      assert_equal open_id_attributes['fullname'], flash[:user].name
      assert_equal open_id_attributes['email'], flash[:user].email
    end
  end

  context "a user with an invalid openID signs in" do
    setup do
      @identity_url = 'http://my.openid.com'
      mock_open_id_authentication(@identity_url, :authenticate => false)
      post :create, :openid_url => @identity_url
    end    

    should_set_the_flash_to /openid message/
    should_render_template :new
  end
  
  context "an existing user signs out" do
    setup do
      @request.session[:user_id] = 1
      put :destroy
    end
    
    should "remove the user id from session" do
      assert_nil @request.session[:user_id]
    end
  end
  
  private
  
  def mock_open_id_authentication(identity_url, options)
    result = stub('result', :successful? => options[:authenticate], :message => 'openid message')
    SessionsController.any_instance.expects(:authenticate_with_open_id).
                                    yields(result, identity_url, open_id_attributes)
  end
  
  def open_id_attributes
    {'email' => 'test@example.com', 'fullname' => 'John Doe'}
  end
  
end
