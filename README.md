# README

-----
* 14/10/2019 SQL Intro, ORM, Models & Migrations - Arvo challenge

* Ruby version: 2.6.3

* Ruby gems: faker

---
__!!!Disclaimer: I'm not 100% sure if the commands listed below are the right ones!!!__

15/10/2019 Database Relations (One To One & One To Many) - Arvo challenge

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
toy.rb:     

            belongs_to :user

user.rb:     

            has_many :toys

* Verify this has been done correctly, by going into rails c, and typing:
    * User.create 

            User.create(email: "test@test.com", password: "123")
    * User.first.toys.create 
    
            User.first.toys.create(name: "pikachu", description: "best pokemon", date: "2019-01-01")
    (If this creates a new toy, then you're all good!)

* Set up a seeds file with our new db structure


-----
__!!!Up to here!!!__
Advanced:
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

Expert:
* Add in CRUD functionality for both users and manufacturers


* Did you remember to push to github?