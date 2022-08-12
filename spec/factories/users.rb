require 'faker'
FactoryBot.define do
  factory :user do
    first_name { "test" }
    last_name { "user" }
    email { Faker::Internet.email }
    password { '123456' }
  end
end
