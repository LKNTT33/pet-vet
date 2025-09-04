class Pet < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy

  def age
    return nil unless birthdate

    today = Date.today
    age = today.year - birthdate.year
    age -= 1 if today < birthdate + age.years
    age
  end
end
