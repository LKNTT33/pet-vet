class AddOtherSpeciesToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :other_species, :string
  end
end
