require 'test_helper'

class MeetingTest < ActiveSupport::TestCase

  context "refreshing meetings from google calendar" do
    setup do
      mock_meetings_xml
      Meeting.refresh_from_calendar
    end

    before_should "delete any existing meetings in the table" do
      Meeting.expects(:delete_all)
    end

    should "populate table with meetings from xml" do
      assert_equal 3, Meeting.count      
    end    
  end
  
  context "meetings exist with various start and end dates" do
    setup do
      @meeting1 = Factory :meeting, :title => 'past', :start_at => 3.days.ago, :end_at => 3.days.ago + 2.hours
      @meeting2 = Factory :meeting, :title => 'future 1', :start_at => 3.days.from_now, :end_at => 3.days.from_now + 2.hours
      @meeting3 = Factory :meeting, :title => 'future 2', :start_at => 10.days.from_now, :end_at => 10.days.from_now + 2.hours      
    end

    should "return the next meeting based on date" do
      assert_equal @meeting2, Meeting.next_meeting
    end
  end
  
  private
  
  def mock_meetings_xml
    xml = File.open("#{RAILS_ROOT}/test/fixtures/calendar.xml") do |f|
      f.read
    end
    Meeting.expects(:meetings_xml).returns(xml)    
  end

end
