require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  context "get index" do
    setup do
      mock_messages_xml
      get :index
    end
    
    should_respond_with :success
    should_assign_to :posts
  end

end
