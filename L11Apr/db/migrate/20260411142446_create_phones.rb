class CreatePhones < ActiveRecord::Migration[7.2]
  def change
    create_table :phones do |t|
      t.references :person, null: false, foreign_key: true
      t.string :label
      t.string :number

      t.timestamps
    end
  end
end
