FactoryBot.define do
  factory :cupon do
    valid_til { Time.now + 35.days }
    discount_rate { 30 }
    promo_code {"AZADI"}
    association :order
  end
end
