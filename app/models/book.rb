require 'amazon/ecs'

class Book < ActiveRecord::Base
  Amazon::Ecs.options = {:aWS_access_key_id => AMAZON_DEV_TOKEN, :aWS_secret_key => AMAZON_SECRET, :response_group => 'Large'}

  before_create :populate_from_amazon
  
  private
  
  def populate_from_amazon
    item = Amazon::Ecs.item_lookup(self.asin).first_item
    self.title = item.get("title")
    self.authors = item.get_array("author").join(', ')
    self.url = item.get("detailpageurl")
    self.image_url = item.get_hash("mediumimage")[:url]
    self.published_at = item.get("publicationdate")
  end
end