class CreateJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :salary

      t.timestamps
    end
  end
end
