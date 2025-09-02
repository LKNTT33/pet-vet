class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {owner: 0, vet: 1}


  has_many :pets, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :appointments, through: :availabilities, as: :vet_appointments
  has_many :appointments, through: :pets, as: :owner_appointments
end
