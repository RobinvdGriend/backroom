User.create(name: Faker::Internet.user_name,
            email: "user_1@example.com",
            password: "password",
            password_confirmation: "password")

98.times do |n|
  User.create(name: Faker::Internet.user_name,
              email: "user_#{n}@example.com",
              password: "password",
              password_confirmation: "password")
end
