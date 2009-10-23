module MeetingsHelper
  
  def format_address_for_display(address)
    formatted = ''
    address.split(',', 3).each do |line|
      formatted << "#{line}<br/>"
    end
    formatted
  end

  def format_address_for_map_url(address)
    formatted = address.clone
    formatted.slice!(0..formatted.index(','))
    CGI::escape(formatted)
  end
  
end
