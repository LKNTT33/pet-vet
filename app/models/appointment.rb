class Appointment < ApplicationRecord
  belongs_to :pet
  belongs_to :availability
  has_many :prescriptions, dependent: :destroy
end
