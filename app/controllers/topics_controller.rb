class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end
  
  def create
    
  end
  
end
