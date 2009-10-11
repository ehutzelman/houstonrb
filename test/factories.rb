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
