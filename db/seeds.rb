User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  brand = Faker::Hipster.word.titlecase
  instrument = Faker::Music.instrument
  blah = Faker::Number.number(8)
  price = Faker::Commerce.price
  users.each { |user| user.items.create!(brand: brand,
                                         model: instrument,
                                         ssn: blah,
                                         cost: price) }
end
