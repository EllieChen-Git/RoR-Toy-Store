# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users_array = []
for i in 1..5
    user = User.create(
        email: Faker::Internet.email,
        password: Faker::Beer.name
    )
    users_array.push(user["id"])
end


for i in 1..20
    toy = Toy.create(
        name: Faker::Beer.name,
        description: Faker::Superhero.power,
        date: Faker::Date.between(from: 365.days.ago, to: Date.today),
        user_id: users_array.sample
    )

    temp_toy_pic = Down.download(Faker::LoremPixel.image + "?random=" + rand(1..1000).to_s) 

    toy.pic.attach(io: temp_toy_pic, filename: File.basename(temp_toy_pic.path))

    puts "#{i} toy(s) created."
end
