class CreateAvailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.boolean :is_available
      t.string :day_of_week
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
