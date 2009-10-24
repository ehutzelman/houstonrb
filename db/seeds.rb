# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Book.delete_all
book_asins = ['0596523696', '0596527314', '0596527462', '0596101325', '0596101996']
book_asins.each do |asin|
  Book.create(:asin => asin)
end