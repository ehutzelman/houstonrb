Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.sequence :name do |n|
  "user#{n}"
end

Factory.define :user do |user|
  user.name { Factory.next :name }
  user.email { Factory.next :email }
  user.identity_url "http://example.myopenid.com"
end

Factory.define :meeting do |meeting|
  meeting.title "Houston Ruby Test Meeting"
  meeting.start_at { 7.days.from_now }
  meeting.end_at { |m| m.start_at + 2.hours }
end