require 'uri'
require 'open-uri'

class Meeting
  attr_accessor :title, :description, :location, :start_time, :end_time
  cattr_accessor :meetings
  
  def initialize(title, description, location, start_time, end_time)
    @title = title
    @description = description || title
    @location = location
    @start_time = Time.zone.parse(start_time) 
    @end_time = Time.zone.parse(end_time)
  end
    
  def self.all
    meetings
  end
  
  def self.next
    meetings.first
  end
  
  def self.reload
    @@meetings = []
    doc = REXML::Document.new(meetings_xml).elements.to_a("//entry").each do |element|
      @@meetings << parse_meeting(element)
    end
  end
  
  private

  def self.meetings
    reload unless @@meetings 
    @@meetings
  end

  def self.meetings_xml
    URI.parse(GOOGLE_CALENDAR_FEED).read
  end
  
  def self.parse_meeting(xml)
    title = xml.elements['title'].text
    description = xml.elements['content'].text
    location = xml.elements['gd:where'].attributes['valueString']
    start_time = xml.elements['gd:when'].attributes['startTime']
    end_time = xml.elements['gd:when'].attributes['endTime']

    Meeting.new(title, description, location, start_time, end_time)    
  end

end