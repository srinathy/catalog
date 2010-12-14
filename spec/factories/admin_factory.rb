Factory.define :admin do |a|
  a.email { Faker::Internet.email }
  a.password "admin"
end
