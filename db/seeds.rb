# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Catalogues
Catalogue.create!(name: "Duong da mat")
Catalogue.create!(name: "Tam & Duong the")
Catalogue.create!(name: "Trang diem")
Catalogue.create!(name: "Nuoc hoa")
Catalogue.create!(name: "Cham soc toc")

catalogues = Catalogue.where("parent_id = :parent_id", parent_id: 0)

# SubCatalogues
catalogues.each { |cata|
	5.times do
	  name = Faker::Lorem.word.capitalize
	  cata.sub_catalogues.create!(name: name)
	end
}

# Products
catalogues.each { |cata|
	sub_catalogues = cata.sub_catalogues
	sub_catalogues.each { |sub_cata|
		8.times do
		  name = Faker::Lorem.word.capitalize
		  price = Faker::Number.between(100, 200)
		  quantity = Faker::Number.between(300, 500)
		  description = Faker::Lorem.sentence(5)	  
		  sub_cata.products.create!(name: name,
		  													description: description,
		                            price: price,
		                            quantity: quantity,                 
		                            active: true)
		end
	}
}

# Order status
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"

# Users
User.create!(name: "Van Nguyen",
	           email: 'bichvannguyenvnn@gmail.com',
	           password: 'foobar',
	           password_confirmation: 'foobar',
	           admin: true)
User.create!(name: "Guest",
	           email: 'guest@gmail.com',
	           password: 'foobar',
	           password_confirmation: 'foobar')