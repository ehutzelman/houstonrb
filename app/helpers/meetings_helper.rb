module MeetingsHelper
  
  def format_address(address)
    formatted = ''
    address.split(',', 3).each do |line|
      formatted << "#{line}<br/>"
    end
    formatted
  end
  
end
