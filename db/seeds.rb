# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cupons = Cupon.create([{
    id: 1,
    promo_code: "DEVS1NC",
    discount_rate: 30,
    valid_til: Time.now + 15.days
  },
  { id: 2,
    promo_code: "PAKARMY",
    discount_rate: 50,
    valid_til: Time.now + 15.days
  },
  { id: 3,
    promo_code: "AZADI",
    discount_rate: 30,
    valid_til: Time.now + 15.days
}])
