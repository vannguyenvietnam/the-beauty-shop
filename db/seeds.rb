# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Catalogues
Catalogue.create!(name: "Skin care")
Catalogue.create!(name: "Moisturizer")
Catalogue.create!(name: "Shower")
Catalogue.create!(name: "Make up")
Catalogue.create!(name: "Perfume")
Catalogue.create!(name: "Hair")
Catalogue.create!(name: "Men")
Catalogue.create!(name: "Facial")
Catalogue.create!(name: "Body moisturizer")
Catalogue.create!(name: "Sampoo")

catalogues = Catalogue.where("parent_id IS NULL")

# SubCatalogues
catalogues.each { |cata|
	10.times do
	  name = Faker::Lorem.word.capitalize
	  cata.sub_catalogues.create!(name: name)
	end
}

# Products
def get_products_amazon(cata, keyword)	
	sub_catalogues = cata.sub_catalogues	
	for i in 0...(sub_catalogues.count)
		sub_cata = sub_catalogues[i]
		page = i + 1
		res = Amazon::Ecs.item_search(keyword, {response_group: 'Medium', 
																									 sort: 'salesrank', 
																									 search_index: 'Beauty',
																									 brand: 'the body shop',
																									 item_page: page})
		
		res.items.each do |item|
			product = Product.new
		  product.name = item.get('ItemAttributes/Title')
		  product.price = item.get('OfferSummary/LowestNewPrice/Amount').to_i
		  product.quantity = item.get('OfferSummary/TotalNew').to_i
		  product.description = item.get('ItemAttributes/Feature')
		  product.active = true		  

		  product.save!
		  
		  sub_cata.cat_products.create(product_id: product.id)
		  cata.cat_products.create(product_id: product.id)

		  image_url = item.get('LargeImage/URL')		   
		  if !image_url.nil?
		  	download = open(image_url.to_s)
			  IO.copy_stream(download, "app/assets/images/products/#{product.id}.jpg")	
			  File.open("app/assets/images/products/#{product.id}.jpg") do |f|
			  	product.update_attributes(picture: f)
			  end	
			end
		end

	end
end
# Skin care
	get_products_amazon(catalogues[0], 'skin care')
# Moisturizer
	get_products_amazon(catalogues[0], 'moisturizer')
# Shower
	get_products_amazon(catalogues[1], 'shower')
# Make up
	get_products_amazon(catalogues[2], 'make up')
# Perfume
	get_products_amazon(catalogues[3], 'perfume')
# Hair
	get_products_amazon(catalogues[4], 'hair')
# Men
	get_products_amazon(catalogues[4], 'men')
# Facial
	get_products_amazon(catalogues[4], 'facial')
# Body moisturizer
	get_products_amazon(catalogues[4], 'body moisturizer')
# Sampoo
	get_products_amazon(catalogues[4], 'Sampoo')


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