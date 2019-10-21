# Toy Store - Rails Practice

-----

* Ruby version: 2.6.3

* Ruby gems: faker

-----
### 14/10/2019 SQL Intro, ORM, Models & Migrations [Completed Core & Advanced]

__Core:__
* Create a new rails app called 'toy_store', using postgresql as our db

            rails new toy_store -d postgresql

* Change into this directory and push our initial app to github

            cd toy_store
            git add .
            git commit -m "initial commit"
            git remote
            git push

* Create our database

            rails db:create

* Using 'rails g migration' - Create a table in our database, called 'toy' that will hold:
    * A name - string
    * A description - text
    * A picture - text
    * A date the item was posted - date
    * A user - string (will just be someone's name that posted the toy)

            rails g migration CreateToys name:string description:text image:text date:date user:string

* Is that the only command we have to run? Nope. rails db:migrate

            rails db:migrate

* Oops, we haven't learnt images yet, so lets generate a new migration to solve this
  (Hint: Google 'rails 5 remove a column from database')
* Remember to migrate our new changes!

            rails g migration RemoveImageFromToys image:text

* Create the model to go with this table
  (Remember rails naming convention)

            1. go to VScode app/model
            2. creaete a file named 'toy.rb'

* Jump into rails console, and have a play around, creating new toys and looking them up

* Setup our seeds file, so that we can create 20 toys
  (may want to use faker to get interesting data)
* Run the seeds file, so we have at least 20 toys

- [terminal] intall faker gem
           
            bundle add faker

- [VScode] db/seeds.rb

            for i in 1..20
                toy = Toy.create(
                    name: Faker::Beer.name,
                    description: Faker::Superhero.power,
                    date: Faker::Date.between(from: 365.days.ago, to: Date.today),
                    user: Faker::Superhero.name,
                )
                puts "#{i} toy(s) created."
            end

- [terminal] run seeds file

            rails db:seed

__Advanced:__
* We now have our toys, but have no way to interact with them
* Add in the necessary views / routes / controllers to make 'toy' a CRUD resource (This includes adding a form!!!)
* Check that we are able to add new toys, and that they remain, even after restarting the server!
* Yay! Our first complete MVC application

* Push those changes up to github!

---

### 15/10/2019 Database Relations (One To One & One To Many) [Completed Core & Advanced]

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

            $rails g model Manufacturer name:string location:string
            $rails db:migrate  

* Run a migration that adds a manufacturer column to our Toy table as a reference
  (May need to clear db)

            $rails g migration AddManufacturerToToys manufacturer:references
            $rails db:migrate  
            
* Add in the relations to our toy model and our manufacturer model
    * A Toy has one manufacturer
    * A Manufacturer can have many toys

model/toy.rb

            class Toy < ApplicationRecord
                belongs_to :user
                has_one :manufacturer
            end

model/manufacturer.rb

            class Manufacturer < ApplicationRecord
                has_many :toys, dependent: :destroy
            end

* Verify this has been done correctly by typing:
    * Manufacturer.create

            Manufacturer.create(name: "GoodOne", location: "WA")

    * Manufacturer.first.toys.create
    (If this creates a new toy, then you're all good!)

            Manufacturer.first.toys.create(name: "R2D2", description: "starwars", date: "2019-10-18", user_id: 1)

__Expert:__
* Add in CRUD functionality for both users and manufacturers

### 16/10/2019 Database Relations (Many To Many & Polymorphic) [Completed Core]

__Core:__

* There are many different categories of toys, so:
    * Generate a Model for categories that will have a name

            rails g model Category name:string
            rails db:migrate

* Create the join table for our toys and categories

            rails g model CategoriesToy category:references toy:references
            rails db:migrate

* Add in the associations to our Category and Toy models

app/models/toy.rb

            class Toy < ApplicationRecord
                belongs_to :user
                has_one :manufacturer

                has_many :categories_toys
                has_many :categories, through: :categories_toys
            end

app/models/category.rb

            class Category < ApplicationRecord
                has_many :categories_toys
                has_many :toys, through: :categories_toys
            end

* To test, open up Rails Console, and type:
    * User.create(email: "test@test.com", password: "test")
    * User.last.toys.create(name: "Toy", description: "Desc", date_posted: Time.now)

    __I believe the correct command should be as follow (as we don't have an arribute called 'date_posted'):__

            User.last.toys.create(name: "Toy", description: "Desc", date: Time.now)

    * Toy.last.categories.create(name: "Fun")

* If that creates a new category, all is gravy!

__Advanced:__
* It will be hard to sell toys without pictures
* Complete all the necessary steps to add a photo to a toy
* Adjust your views, so these images can be displayed

__Expert:__
* This will be the last day we will work on this app in classtime
* So take the time to style it, and to improve the functionality
  (I.e. We are currently showing the user_id for a toy, maybe we should show the email)

### 21/10/2019 Image Uploading & Amazon S3 [Completed - Advanced (convert HTML fomr to Rails form)]

__Optional - Advanced:__
* Back to the toy store
* If you have fallen behind:
  * git clone https://github.com/CoderAcademy-SYD/toy_store.git -b database-relations-many-to-many
  * Change into the directory, bundle install, rails db:setup

* Complete the functionality of this app:
  * Change the forms into rails forms

app\controllers\toys_controller.rb

app\views\toys\new.html.erb

        <h1>Create a Toy</h1>

        <%= form_with(model: @toy, local: true) do |form| %>
            <div>
                <%= form.label :name %>
                <%= form.text_field :name %>
            </div>

            <div>
                <%= form.label :description %>
                <%= form.text_area :description %>
            </div>

            <div>
                <%= form.label :date %>
                <%= form.date_field :date %>
            </div>

            <div>
                <%= form.label :user %>
                <%= form.number_field :user %>
            </div>

            <div>
                <%= form.submit %>
            </div>
        <% end %>

app\views\toys\show.html.erb

            <h1>This is toy number: <%= @toy[:id] %></h1>

            <div>
                <ul>
                    <li>Name: <%= @toy[:name] %> </li>
                    <li>Description: <%= @toy[:description]%> </li>
                    <li>Date: <%=@toy[:date]%></li>
                    <li>User: <%=@toy[:user_id]%></li>
                </ul>
            </div>

            <div>
                <%= button_to 'Delete', toy_path(@toy),
                method: :delete,
                data: { confirm: "Are you sure?" }%>
            </div>

            <div>
            <%= form_with(model: @toy, local: true) do |form| %>

                <div>
                    <%= form.label :name %>
                    <%= form.text_field :name %>
                </div>

                <div>
                    <%= form.label :description %>
                    <%= form.text_area :description %>
                </div>

                <div>
                    <%= form.label :date %>
                    <%= form.date_field :date %>
                </div>

                <div>
                    <%= form.label :user %>
                    <%= form.number_field :user %>
                </div>

                <div>
                    <%= form.submit %>
                </div>

            <% end %>
            </div>


       

  * Complete the image functionality, so the toys can display a picture
  * Style the app

__Optional - Expert:__
  * Look into the gem 'Devise' (We will learn about this next lesson)
  * Use this gem to authorise and authenticate our users
    (If this is hard to follow, skip it for now)

  * Complete any other functionality the site is missing
  * Push to github and heroku!