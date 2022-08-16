FactoryBot.define do
  factory :product do
   name { "temp" }
   serial_no { 1 }
   price { 12345 }
   description { "qwertyuiop" }
   association :user
  end
end
