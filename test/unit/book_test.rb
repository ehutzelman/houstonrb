require 'test_helper'

class BookTest < ActiveSupport::TestCase

  context "creating a new book" do
    setup do
      asin = '0596523696'
      mock_amazon_ecs(asin)
      @book = Book.create(:asin => asin)
    end

    should "populate model with book title" do
      assert_equal 'Mock Title', @book.title
    end

    should "populate model with book authors" do
      assert_equal 'Mock Author 1, Mock Author 2', @book.authors
    end

    should "populate model with book url" do
      assert_equal 'Mock URL', @book.url
    end
    
    should "populate model with book image url" do
      assert_equal 'Mock Image URL', @book.image_url
    end

    should "populate model with book published date" do
      assert @book.published_at.is_a? Time
    end
  end

  private
  
  def mock_amazon_ecs(asin)
    item_list = stub()
    item_list.stubs(:first_item).returns(stub_amazon_item)
    Amazon::Ecs.expects(:item_lookup).with(asin).returns(item_list)
  end
  
  def stub_amazon_item
    amazon_item = stub()
    amazon_item.stubs(:get).with('title').returns('Mock Title')
    amazon_item.stubs(:get).with('detailpageurl').returns('Mock URL')
    amazon_item.stubs(:get).with('publicationdate').returns(Time.now)
    amazon_item.stubs(:get_hash).with('mediumimage').returns({:url => 'Mock Image URL'})
    amazon_item.stubs(:get_array).with('author').returns(['Mock Author 1', 'Mock Author 2'])

    amazon_item    
  end
end
