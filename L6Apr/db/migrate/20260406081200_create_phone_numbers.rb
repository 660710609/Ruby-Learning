class CreatePhoneNumbers < ActiveRecord::Migration[7.2]
  def change
    create_table :phone_numbers do |t|
      t.string :label
      t.string :number
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
