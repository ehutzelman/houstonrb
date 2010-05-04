class Topic < ActiveRecord::Base

  belongs_to :requester, :class_name => "User", :foreign_key => "requester_user_id"
  belongs_to :presenter, :class_name => "User", :foreign_key => "presenter_user_id"
  has_many :topic_votes, :dependent => :destroy
  
  validates_presence_of :description, :requester_user_id
  
  default_scope :conditions => {:is_active => true}, :order => 'topic_votes_count DESC'
  
end
