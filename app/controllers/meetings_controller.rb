class MeetingsController < ApplicationController

  def index
    @meetings = Meeting.all(:limit => 4)
  end
  
end
