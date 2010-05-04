require 'test_helper'

class TopicsControllerTest < ActionController::TestCase

  context "get index" do
    setup { get :index }
    
    should_respond_with :success
    should_assign_to :topics
  end
  
  context "create a new topic to present" do
    setup do
      login_as @user = Factory(:user)
      post :create, :description => 'my new topic', :user_will_present => 'true'
    end

    should_change 'Topic.count', :by => 1
    should_redirect_to("topics_path") { topics_path }
    should_set_the_flash_to(/added/)
    
    should "assign user as presenter" do
      assert_equal @user, Topic.last.presenter
    end

    should "assign user as requester" do
      assert_equal @user, Topic.last.requester
    end
  end

  context "create a new topic to request" do
    setup do
      login_as @user = Factory(:user)
      post :create, :description => 'my new topic', :user_will_present => 'false'
    end

    should_change('number of topics', :by => 1) { Topic.count }
    should_redirect_to("topics_path") { topics_path }
    should_set_the_flash_to(/added/)
    
    should "assign user as requester" do
      assert_equal @user, Topic.last.requester
    end

    should "not assign user as presenter" do
      assert_not_equal @user, Topic.last.presenter
    end
  end
  
  context "create vote for topic" do
    setup do
      login_as @user = Factory(:user)
      @topic = Factory :topic
      post :vote, :id => @topic.id
    end

    should_change('number of topic votes', :by => 1) { TopicVote.count }
    should_redirect_to("topics_path") { topics_path }
    should_set_the_flash_to(/recorded/)
  end
  
  context "remove a topic as presenter" do
    setup do
      login_as @user = Factory(:user)
      @topic = Factory :topic, :presenter_user_id => @user.id
      delete :destroy, :id => @topic.id
    end
    
    should_redirect_to("topics_path") { topics_path }
    should_set_the_flash_to(/removed/)
    
    should "delete the topic" do
      assert_nil Topic.find_by_id(@topic.id)
    end
  end

  context "volunteer to present a topic" do
    setup do
      login_as @user = Factory(:user)
      @topic = Factory :topic
      put :volunteer, :id => @topic.id
    end
    
    should "assign user as presenter" do
      assert_equal @user, @topic.reload.presenter
    end
    
  end
end
