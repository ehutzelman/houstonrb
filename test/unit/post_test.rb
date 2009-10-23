require 'test_helper'

class PostTest < ActiveSupport::TestCase

  context "loading messages from yahoo groups" do
    setup do
      mock_messages_xml
      @posts = Post.all
    end

    should "return a non-empty array of posts" do
      assert !@posts.empty?
    end
    
    should "populate attributes of a post" do
      post = @posts.first
      assert !post.title.blank?
      assert !post.author.blank?
      assert !post.description.blank?
      assert !post.url.blank?
      assert !post.created_at.blank?
    end
  end
  
  private
  
  def mock_messages_xml
    xml = File.open("#{RAILS_ROOT}/test/fixtures/messages.xml") do |f|
      f.read
    end
    Post.expects(:messages_xml).returns(xml)    
  end
  
end
