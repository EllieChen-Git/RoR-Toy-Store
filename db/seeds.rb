# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 1..20
    Toy.create(
        name: Faker::Beer.name,
        description: Faker::Superhero.power,
        date: Faker::Date.between(from: 365.days.ago, to: Date.today),
        user: Faker::Artist.name
    )

    puts "#{i} toy(s) created."
end
