# Toy Store - Rails Practice

-----

* Ruby version: 2.6.3

* Ruby gems: faker

-----
### 14/10/2019 SQL Intro, ORM, Models & Migrations - Arvo challenge [Completed Core & Advanced]

__Core:__
* Create a new rails app called 'toy_store', using postgresql as our db
* Change into this directory and push our initial app to github
* Create our database

* Using 'rails g migration' - Create a table in our database, called 'toy' that will hold:
    * A name - string
    * A description - text
    * A picture - text
    * A date the item was posted - date
    * A user - string (will just be someone's name that posted the toy)
* Is that the only command we have to run? Nope. rails db:migrate
* Oops, we haven't learnt images yet, so lets generate a new migration to solve this
  (Hint: Google 'rails 5 remove a column from database')
* Remember to migrate our new changes!

* Create the model to go with this table
  (Remember rails naming convention)

* Jump into rails console, and have a play around, creating new toys and looking them up

* Setup our seeds file, so that we can create 20 toys
  (may want to use faker to get interesting data)
* Run the seeds file, so we have at least 20 toys

__Advanced:__
* We now have our toys, but have no way to interact with them
* Add in the necessary views / routes / controllers to make 'toy' a CRUD resource (This includes adding a form!!!)
* Check that we are able to add new toys, and that they remain, even after restarting the server!
* Yay! Our first complete MVC application

* Push those changes up to github!

---
__!!!Disclaimer: I'm not 100% sure if the commands listed below are the right ones!!!__

### 15/10/2019 Database Relations (One To One & One To Many) - Arvo challenge [Only Completed Core]

__Core:__
* We want to add users to our app
* Use rails g model to create a User model that will have:
    * An email - string
    * A password - string

            $rails g model User email:string password:string
            $rails db:migrate

* Now, we can add users, and we can add toys, but theres no relation
* Use a migration to edit our Toy table, so that our 'user' column references our user table (May need to clear database first)

            1. Comment out the method in seeds.rb to create 20 Toys
            2. $ rails db:setup: to clear database
            3. $ rails g migration AddUserToToys user:references

* Add in the relations to both our models

    * toy.rb:     

                belongs_to :user

    * user.rb:     

                has_many :toys, dependent: :destroy  

* Verify this has been done correctly, by going into rails c, and typing:
    * User.create 

            User.create(email: "test@test.com", password: "123")
    * User.first.toys.create 
    
            User.first.toys.create(name: "pikachu", description: "best pokemon", date: "2019-01-01")
    (If this creates a new toy, then you're all good!)

* Set up a seeds file with our new db structure

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
                puts "#{i} toy(s) created."
            end


__Advanced:__
* We want to generate a model for our manufacturer table. It should contain:
    * Name - string
    * Location - string

* Run a migration that adds a manufacturer column to our Toy table as a reference
  (May need to clear db)
* Add in the relations to our toy model and our manufacturer model
    * A Toy has one manufacturer
    * A Manufacturer can have many toys

* Verify this has been done correctly by typing:
    * Manufacturer.create
    * Manufacturer.first.toys.create
    (If this creates a new toy, then you're all good!)

__Expert:__
* Add in CRUD functionality for both users and manufacturers


* Did you remember to push to github?