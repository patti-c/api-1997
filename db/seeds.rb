User.create(name: "Patti", username: "pattipig", email: "patti@mail.com", password: "pattipassword")
patti = User.find_by(username: "pattipig")
User.create(name: "Alex", username: "lexilicious", email: "alex@mail.com", password: "alexpassword")
User.create(name: "Orie", username: "dragongyrl", email: "orie@mail.com", password: "oriepassword")
alex = User.find_by(username: "lexilicious")
User.create(name: "Michael", username: "pokeboy30", email: "michael@mail.com", password: "michaelpassword")
michael = User.find_by(username: "pokeboy30")
orie = User.find_by(username: "dragongyrl")
Relationship.find_or_create_by(user: patti, friend: alex)
Relationship.find_or_create_by(user: patti, friend: michael)
