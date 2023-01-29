FactoryBot.define do
  factory :order do
   total_amount { 10000 }
   discounted_amount { 500 }
   association :user
  end
end
