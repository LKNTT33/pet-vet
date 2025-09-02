class CreatePrescriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :prescriptions do |t|
      t.string :dosage
      t.timestamp :start_date
      t.timestamp :end_date
      t.text :special_instructions
      t.references :medicine, null: false, foreign_key: true
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
