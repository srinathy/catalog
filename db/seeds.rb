# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Factory.find_definitions

20.times{
  Factory.build(:videofile).save(false)
}

puts "Added 20 files"

Factory.create(:admin)

puts "Added admin with email "+Admin.find(:first).email