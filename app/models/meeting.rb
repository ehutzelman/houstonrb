require 'uri'
require 'open-uri'

class Meeting < ActiveRecord::Base

  class << self
    def next_meeting
      find(:first, :conditions => ["end_at > ?", Time.now], :order => :start_at)
    end
  
    def refresh_from_calendar
      Meeting.delete_all
      entries = REXML::Document.new(meetings_xml).elements.to_a("//entry")
      entries[0..9].each_with_index do |element, index|
        create_meeting_from_xml(element, index + 1)
      end    
    end

    private
    
    def meetings_xml
      URI.parse(GOOGLE_CALENDAR_FEED).read
    end

    def create_meeting_from_xml(xml, id)
      meeting = Meeting.new

      meeting.id = id
      meeting.title = xml.elements['title'].text
      meeting.description = xml.elements['content'].text
      meeting.location = xml.elements['gd:where'].attributes['valueString']
      meeting.start_at = xml.elements['gd:when'].attributes['startTime']
      meeting.end_at = xml.elements['gd:when'].attributes['endTime']

      meeting.save
    end
  end
  
end