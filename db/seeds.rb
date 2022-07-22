# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    require 'faker'

    Role.create(name: "administrator" , description: "admin")
    Role.create(name: "standard" , description: "standard user")
    Role.create(name: "regular" , description: "regular user") 

    User.create(first_name: "admin", last_name: "admin", email: "admin@mail.com", password_digest: "password-admin", role_id: 1)

    (1..10).each do 
        User.create!(
            first_name: Faker::Name.first_name, 
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            password_digest: "password-standard", 
            role_id: 2
        )
    end 

    (1..10).each do 
        User.create!(
            first_name: Faker::Name.first_name, 
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            password_digest: "password-regular", 
            role_id: 3
        )
    end 
