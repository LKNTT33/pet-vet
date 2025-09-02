class CreateMedicines < ActiveRecord::Migration[7.1]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :description
      t.string :category
      t.text :instructions

      t.timestamps
    end
  end
end
