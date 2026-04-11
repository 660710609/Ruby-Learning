class CreateOilPrices < ActiveRecord::Migration[7.2]
  def change
    create_table :oil_prices do |t|
      t.date :date
      t.string :fuel_type
      t.decimal :price

      t.timestamps
    end
  end
end
