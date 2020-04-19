FactoryBot.define do
  factory :discount, class: Discount do
    name        { Faker::Commerce.product_name}
    percent_off { Faker::Number.between(from: 1, to: 100) }
    min_quantity{ Faker::Number.between(from: 1, to: 20) }
    association :merchant, factory: :merchant
  end
end
