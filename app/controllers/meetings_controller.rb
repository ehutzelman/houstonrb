class MeetingsController < ApplicationController

  def index
    @meetings = Meeting.all(:limit => 4)
  end
  
  def refresh
    Meeting.refresh_from_calendar
    redirect_to meetings_path
  end
  
end
