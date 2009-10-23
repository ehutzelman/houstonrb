require 'test_helper'

class MeetingsControllerTest < ActionController::TestCase

  context "get index" do
    setup { get :index }
    
    should_respond_with :success
    should_assign_to :meetings
  end
  
end
