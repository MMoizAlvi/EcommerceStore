# frozen_string_literal: true
cupons = Cupon.create([{
                        id: 1,
                        promo_code: 'DEVS1NC',
                        discount_rate: 30,
                        valid_til: Time.zone.now + 35.days
                      },
                       { id: 2,
                         promo_code: 'PAKARMY',
                         discount_rate: 50,
                         valid_til: Time.zone.now + 35.days },
                       { id: 3,
                         promo_code: 'AZADI',
                         discount_rate: 30,
                         valid_til: Time.zone.now + 35.days }])
