
megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

Discount.create(name: "Going out of business", percent_off: 25, min_quantity: 2, merchant_id: megan.id)
Discount.create(name: "Take it all", percent_off: 50, min_quantity: 3, merchant_id: megan.id)
Discount.create(name: "Going out of business", percent_off: 25, min_quantity: 2, merchant_id: brian.id)
Discount.create(name: "Take it all", percent_off: 50, min_quantity: 3, merchant_id: brian.id)


User.create(name: "Regular User", address: "1234 Regular St", city: "Regular City", state: "Regular State", zip: "00000", email: "user@example.com", password: "password_regular")
User.create(name: "Merchant Employee", address: "1234 Merchant St", city: "Merchant City", state: "Merchant State", zip: "00001", email: "merchant@example.com", password: "password_merchant", role: 1, merchant: megan)
User.create(name: "Admin User", address: "1234 Admin St", city: "Admin City", state: "Admin State", zip: "00002", email: "admin@example.com", password: "password_admin", role: 2)
