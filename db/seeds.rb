# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

patti = User.create(name: "Patti", username: "pattipig", email: "patti@mail.com", password: "pattipassword")
alex = User.create(name: "Alex", username: "lexilicious", email: "alex@mail.com", password: "alexpassword")
michael = User.create(name: "Michael", username: "pokeboy30", email: "michael@mail.com", password: "michaelpassword")
Relationship.create(user: patti, friend: alex)
Relationship.create(user: patti, friend: michael)
