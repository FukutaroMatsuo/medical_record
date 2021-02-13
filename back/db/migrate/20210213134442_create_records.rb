class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.date :day
      t.string :subjective
      t.string :objective
      t.string :assessment
      t.string :plan
      t.references :patient, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
