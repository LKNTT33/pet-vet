class AddVaccineFieldsToPrescriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :prescriptions, :date_of_administration, :date
    add_column :prescriptions, :immunization_coverage, :integer
  end
end
