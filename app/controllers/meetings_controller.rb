class MeetingsController < ApplicationController

  def index
    @meetings = Meeting.all
  end
  
end
