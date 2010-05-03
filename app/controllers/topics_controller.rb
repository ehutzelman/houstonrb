class TopicsController < ApplicationController

  before_filter :require_user, :except => :index
  
  def index
    @topics = Topic.all
  end
  
  def create
    @topic = Topic.new(:description => params[:description])
    @topic.requester_user_id = current_user.id
    @topic.presenter_user_id = current_user.id if params[:user_will_present] == "true"
    
    if @topic.save
      flash[:notice] = "Your topic has been added"
    else
      flash[:notice] = "Your topic could not be created, please enter a valid description"
    end
    
    redirect_to topics_path
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    
    flash[:notice] = "Topic has been removed"
    redirect_to topics_path
  end
  
  def vote
    @topic = Topic.find(params[:id])
    @topic.topic_votes.create(:user_id => current_user.id)
    
    flash[:notice] = "Your vote has been recorded"
    redirect_to topics_path
  end
  
  def volunteer
    @topic = Topic.find(params[:id])
    @topic.presenter_user_id = current_user.id
    
    @topic.save
    flash[:notice] = "You have been assigned as the presenter for the topic"
    
    redirect_to topics_path    
  end
  
  private
  
  def require_user
    unless current_user
      flash[:notice] = "You must be signed in to work with topics"
      redirect_to topics_path
    end
  end
  
end
