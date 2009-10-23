require 'open-uri'

class Post
  attr_accessor :title, :author, :description, :url, :created_at

  RSS_URL = "http://rss.groups.yahoo.com/group/Houston-RoR/rss"
  
  def self.all
    posts = []
    REXML::Document.new(messages_xml).elements.to_a("//item").each do |element|
      posts << create_post_from_xml(element)
    end
    
    posts
  end

  def self.messages_xml
    URI.parse(RSS_URL).read
  end
  
  def self.create_post_from_xml(xml)
    post = Post.new
    post.title = xml.elements['title'].text
    post.description = xml.elements['description'].text rescue nil
    post.created_at = Time.parse(xml.elements['pubDate'].text)
    post.author = xml.elements['dc:creator'].text
    post.url = xml.elements['link'].text

    post
  end
  
end