class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.string :status
      t.references :pet, null: false, foreign_key: true
      t.references :availability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
