class ChangeCuponColumnConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:cupons, :promo_code, false)
    change_column_null(:cupons, :discount_rate, false)
    change_column_null(:cupons, :valid_til, false)
  end
end
