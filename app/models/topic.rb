class Topic < ActiveRecord::Base
  
  default_scope :conditions => {:is_active => true}
  
end
