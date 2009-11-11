ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :us => '%m/%d/%Y',
  :us_with_time => '%m/%d/%y, %l:%M %p',
  :short_day => '%e %B %Y',
  :medium_day => "%A, %B %d",
  :long_day => '%A, %e %B %Y',
  :short_date => "%x",
  :long_date => "%B %d, %Y",
  :time => "%I:%M %p"
)