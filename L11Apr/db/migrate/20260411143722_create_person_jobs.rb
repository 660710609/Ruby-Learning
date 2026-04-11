class CreatePersonJobs < ActiveRecord::Migration[7.2]
  def change
    create_table :person_jobs do |t|
      t.references :person, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
