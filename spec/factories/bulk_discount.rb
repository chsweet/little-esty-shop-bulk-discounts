FactoryBot.define do
  factory :bulk_discount do
    percentage_discount { Faker::Number.within(range: 10..30) }
    quantity { Faker::Number.within(range: 5..10) }
    merchant
  end
end
