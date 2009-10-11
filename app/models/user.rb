class User < ActiveRecord::Base

  validates_presence_of :identity_url
  validates_presence_of :name
  validates_presence_of :email
  validates_format_of :email, :with => EMAIL_REGEX, :allow_blank => true
  validates_format_of :url, :with => URL_REGEX, :allow_blank => true
  validates_uniqueness_of :identity_url, :case_sensitive => false
  before_validation :normalize_identity_url


  private

  def normalize_identity_url
    self.identity_url = OpenIdAuthentication.normalize_identifier(self.identity_url)
  rescue OpenIdAuthentication::InvalidOpenId
    
  end
  
end
