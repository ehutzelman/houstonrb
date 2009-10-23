require 'rss'
require 'open-uri'

class Post
  attr_accessor :title, :author, :description, :url, :created_at

  RSS_URL = "http://rss.groups.yahoo.com/group/Houston-RoR/rss"
  
  def initialize(item)
    self.title = item.title
    self.author = item.dc_creator
    self.description = item.description
    self.url = item.link
    self.created_at = Time.parse(item.pubDate.to_s)
  end
  
  def self.all
    posts = []
    RSS::Parser.parse(messages_xml, false).items.each_with_index do |item, i|
      posts << Post.new(item)
    end  
    posts
  end

  def self.messages_xml
    URI.parse(RSS_URL).read
  end
  
end