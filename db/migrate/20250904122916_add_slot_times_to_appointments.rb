class AddSlotTimesToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :slot_start, :datetime
    add_column :appointments, :slot_end, :datetime
  end
end
