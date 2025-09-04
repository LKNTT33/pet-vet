class AddBirthdateToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :birthdate, :date
  end
end
