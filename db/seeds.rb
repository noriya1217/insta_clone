50.times do |n|
  name = Faker::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  image = ""
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               image: image,
               )
end