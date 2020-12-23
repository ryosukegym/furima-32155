FactoryBot.define do
  factory :item do
    association :user
    title { 'title' }
    explanation { Faker::Lorem.sentence }
    price { 1000 }
    category_id { Faker::Number.between(from: 2, to: 10) }
    product_condition_id { 2 }
    delivery_fee_id { 2 }
    prefectural_id { 2 }
    day_to_ship_id { 3 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.png'), filename: 'test.png')
    end
  end
end

