# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
BulkDiscount.destroy_all

BulkDiscount.create!(percentage_discount: 20, quantity: 10, merchant_id: 5)
BulkDiscount.create!(percentage_discount: 15, quantity: 15, merchant_id: 5)
BulkDiscount.create!(percentage_discount: 25, quantity: 25, merchant_id: 7)
BulkDiscount.create!(percentage_discount: 20, quantity: 10, merchant_id: 7)
BulkDiscount.create!(percentage_discount: 20, quantity: 10, merchant_id: 8)
BulkDiscount.create!(percentage_discount: 15, quantity: 10, merchant_id: 8)
