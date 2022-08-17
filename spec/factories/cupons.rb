FactoryBot.define do
  factory :cupon do
    valid_til {"2022-09-20 17:15:33"}
    discount_rate { 30 }
    promo_code {"AZADI"}
    association :order
  end
end
