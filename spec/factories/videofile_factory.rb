Factory.define(:videofile) do |a|
  a.title { Faker::Lorem.words(1 + rand(3)).join(' ').capitalize }
  a.body { Faker::Lorem.paragraph }
  a.poster { File.new(File.join(RAILS_ROOT, 'spec', 'files', 'test0.jpg'))}
end