require 'test_helper'

class MeetingTest < ActiveSupport::TestCase


  context "when asked for meetings" do
    setup do
      xml = File.open("#{RAILS_ROOT}/test/fixtures/calendar.xml") do |f|
        f.read
      end
      Meeting.stubs(:meetings_xml).returns(xml)
    end
    
    should "return an array of all meetings for Meeting#all" do
      assert Meeting.all.length > 0
    end
    
    should "return the next meeting for Meeting#next" do
      assert Meeting.next.instance_of?(Meeting)
    end    
  end
  
  should "cache meeting information for 24 hours" do
  end
  
  should "use meeting title for description if no description exists" do
  end

end
