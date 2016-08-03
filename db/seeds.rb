# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Catalogues
Catalogue.create!(name: "Moisturizer")
Catalogue.create!(name: "Shower")
Catalogue.create!(name: "Make up")
Catalogue.create!(name: "Perfume")
Catalogue.create!(name: "Hair")

catalogues = Catalogue.where("parent_id IS NULL")

# SubCatalogues
catalogues.each { |cata|
	5.times do
	  name = Faker::Lorem.word.capitalize
	  cata.sub_catalogues.create!(name: name)
	end
}

# Products
image_id = 2
# Moisturizer
	cata = catalogues[0]
	sub_catalogues = cata.sub_catalogues
	page = 1
	sub_catalogues.each { |sub_cata|
		res = Amazon::Ecs.item_search('moisturizer', {response_group: 'Medium', 
																									 sort: 'salesrank', 
																									 search_index: 'Beauty',
																									 brand: 'the body shop',
																									 item_page: page})
		page += 1
		res.items.each do |item|
			product = Product.new
		  product.name = item.get('ItemAttributes/Title')
		  product.price = item.get('OfferSummary/LowestNewPrice/Amount')
		  product.quantity = item.get('OfferSummary/TotalNew')
		  product.description = item.get('ItemAttributes/Feature')
		  product.active = true

		  image_url = item.get('LargeImage/URL')	  
		  IO.copy_stream(open(image_url), "app/assets/images/products/#{image_id}.jpg")	
		  File.open("app/assets/images/products/#{image_id}.jpg") do |f|
		  	product.picture = f
		  end

		  product.save!
		  
		  sub_cata.cat_products.create(product_id: product.id)
		  cata.cat_products.create(product_id: product.id)

		  image_id += 1
		end
	}

# Shower
	cata = catalogues[0]
	sub_catalogues = cata.sub_catalogues
	page = 1
	sub_catalogues.each { |sub_cata|
		res = Amazon::Ecs.item_search('shower', {response_group: 'Medium', 
																									 sort: 'salesrank', 
																									 search_index: 'Beauty',
																									 brand: 'the body shop',
																									 item_page: page})
		page += 1
		res.items.each do |item|
			product = Product.new
		  product.name = item.get('ItemAttributes/Title')
		  product.price = item.get('OfferSummary/LowestNewPrice/Amount')
		  product.quantity = item.get('OfferSummary/TotalNew')
		  product.description = item.get('ItemAttributes/Feature')
		  product.active = true

		  image_url = item.get('LargeImage/URL')	  
		  IO.copy_stream(open(image_url), "app/assets/images/products/#{image_id}.jpg")	
		  File.open("app/assets/images/products/#{image_id}.jpg") do |f|
		  	product.picture = f
		  end

		  product.save!
		  
		  sub_cata.cat_products.create(product_id: product.id)
		  cata.cat_products.create(product_id: product.id)

		  image_id += 1
		end
	}

# Make up
	cata = catalogues[0]
	sub_catalogues = cata.sub_catalogues
	page = 1
	sub_catalogues.each { |sub_cata|
		res = Amazon::Ecs.item_search('make up', {response_group: 'Medium', 
																									 sort: 'salesrank', 
																									 search_index: 'Beauty',
																									 brand: 'the body shop',
																									 item_page: page})
		page += 1
		res.items.each do |item|
			product = Product.new
		  product.name = item.get('ItemAttributes/Title')
		  product.price = item.get('OfferSummary/LowestNewPrice/Amount')
		  product.quantity = item.get('OfferSummary/TotalNew')
		  product.description = item.get('ItemAttributes/Feature')
		  product.active = true

		  image_url = item.get('LargeImage/URL')	  
		  IO.copy_stream(open(image_url), "app/assets/images/products/#{image_id}.jpg")	
		  File.open("app/assets/images/products/#{image_id}.jpg") do |f|
		  	product.picture = f
		  end

		  product.save!
		  
		  sub_cata.cat_products.create(product_id: product.id)
		  cata.cat_products.create(product_id: product.id)

		  image_id += 1
		end
	}

# Perfume
	cata = catalogues[0]
	sub_catalogues = cata.sub_catalogues
	page = 1
	sub_catalogues.each { |sub_cata|
		res = Amazon::Ecs.item_search('perfume', {response_group: 'Medium', 
																									 sort: 'salesrank', 
																									 search_index: 'Beauty',
																									 brand: 'the body shop',
																									 item_page: page})
		page += 1
		res.items.each do |item|
			product = Product.new
		  product.name = item.get('ItemAttributes/Title')
		  product.price = item.get('OfferSummary/LowestNewPrice/Amount')
		  product.quantity = item.get('OfferSummary/TotalNew')
		  product.description = item.get('ItemAttributes/Feature')
		  product.active = true

		  image_url = item.get('LargeImage/URL')	  
		  IO.copy_stream(open(image_url), "app/assets/images/products/#{image_id}.jpg")	
		  File.open("app/assets/images/products/#{image_id}.jpg") do |f|
		  	product.picture = f
		  end

		  product.save!
		  
		  sub_cata.cat_products.create(product_id: product.id)
		  cata.cat_products.create(product_id: product.id)

		  image_id += 1
		end
	}

# Hair
	cata = catalogues[0]
	sub_catalogues = cata.sub_catalogues
	page = 1
	sub_catalogues.each { |sub_cata|
		res = Amazon::Ecs.item_search('hair', {response_group: 'Medium', 
																									 sort: 'salesrank', 
																									 search_index: 'Beauty',
																									 brand: 'the body shop',
																									 item_page: page})
		page += 1
		res.items.each do |item|
			product = Product.new
		  product.name = item.get('ItemAttributes/Title')
		  product.price = item.get('OfferSummary/LowestNewPrice/Amount')
		  product.quantity = item.get('OfferSummary/TotalNew')
		  product.description = item.get('ItemAttributes/Feature')
		  product.active = true

		  image_url = item.get('LargeImage/URL')	  
		  IO.copy_stream(open(image_url), "app/assets/images/products/#{image_id}.jpg")	
		  File.open("app/assets/images/products/#{image_id}.jpg") do |f|
		  	product.picture = f
		  end

		  product.save!
		  
		  sub_cata.cat_products.create(product_id: product.id)
		  cata.cat_products.create(product_id: product.id)

		  image_id += 1
		end
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