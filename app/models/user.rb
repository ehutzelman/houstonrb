class User < ActiveRecord::Base

  validates_presence_of :identity_url
  validates_presence_of :name
  validates_presence_of :email
  validates_format_of :email, :with => EMAIL_REGEX, :allow_blank => true
  validates_format_of :url, :with => URL_REGEX, :allow_blank => true
  validates_uniqueness_of :identity_url, :case_sensitive => false
  before_validation :normalize_url

  default_scope :order => 'created_at'
  named_scope :displayable, :conditions => ["display = ? and bio <> ''", true]
  
  def image_url
    email_hash = Digest::MD5.hexdigest(self.email)
    "http://www.gravatar.com/avatar/#{email_hash}"
  end

  def self.random
    User.displayable.first(:order => 'random()') # only works for sqlite
    #User.displayable.first(:order => 'rand()') # only works for mysql
  end
  
  private

  def normalize_url
    self.url = "http://#{self.url}" unless self.url.blank? || self.url =~ /^http/i
  end
end
