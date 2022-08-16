FactoryBot.define do
  factory :cart_product do
   quantity { 1 }
   association :cart
   association :product
  end
end
