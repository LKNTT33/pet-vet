# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# 1. Clean the database :lata_de_lixo:
puts "Cleaning database..."
Appointment.destroy_all
Availability.destroy_all
Pet.destroy_all
User.destroy_all
Medicine.destroy_all
Prescription.destroy_all

puts "Seeding database..."

vet1 = User.create!(
  email: "joao@gmail.com",
  password: "joao123",
  first_name: "João",
  last_name: "Sobral",
  role: :vet,
  phone: "960000199",
  address: "Beverly Hills, 6",
  specialty: "Ophthalmology",
  city: "Lisbon",
  clinic_name: "Corkoak Specialists"
)

vet2 = User.create!(
  email: "maria@gmail.com",
  password: "maria123",
  first_name: "Maria",
  last_name: "Silva",
  role: :vet,
  phone: "961111222",
  address: "Rua Nova, 10",
  specialty: "Dermatology",
  city: "Bordeaux",
  clinic_name: "Pet SkinCare Clinic"
)

vet3 = User.create!(
  email: "pedro@gmail.com",
  password: "pedro123",
  first_name: "Pedro",
  last_name: "Almeida",
  role: :vet,
  phone: "962222333",
  address: "Avenida Central, 45",
  specialty: "Cardiology",
  city: "Lisbon",
  clinic_name: "HeartVet Clinic"
)

vet4 = User.create!(
  email: "ana@gmail.com",
  password: "ana123",
  first_name: "Ana",
  last_name: "Costa",
  role: :vet,
  phone: "963333444",
  address: "Rua das Flores, 23",
  specialty: "Toxicology",
  city: "Bordeaux",
  clinic_name: "Vet Clinic"
)

vet5 = User.create!(
  email: "carlos@gmail.com",
  password: "carlos123",
  first_name: "Carlos",
  last_name: "Ferreira",
  role: :vet,
  phone: "964444555",
  address: "Rua do Sol, 7",
  specialty: "Surgery",
  city: "Lisbon",
  clinic_name: "SurgeryVet Clinic"
)

owner1 = User.create!(
  email: "laurie@gmail.com",
  password: "laurie123",
  first_name: "Laurie",
  last_name: "Knott",
  role: :owner
)

owner2 = User.create!(
  email: "ricardo@gmail.com",
  password: "ricardo123",
  first_name: "Ricardo",
  last_name: "Moitas",
  role: :owner
)

pet1 = Pet.create!(name: "Carminho", species: "Dog", age: 3, user: owner2)
pet2 = Pet.create!(name: "Paulie", species: "Cat", age: 4, user: owner1)

vet1_monday = Availability.create!(
  user: vet1,
  day_of_week: "Monday",
  start_time: Time.zone.parse("10:00"),
  end_time: Time.zone.parse("13:00"),
  is_available: true
)

vet2_tuesday = Availability.create!(
  user: vet2,
  day_of_week: "Tuesday",
  start_time: Time.zone.parse("10:00"),
  end_time: Time.zone.parse("15:00"),
  is_available: true
)

appt1 = Appointment.create!(pet: pet1, availability: vet1_monday, status: "pending")
appt2 = Appointment.create!(pet: pet2, availability: vet2_tuesday, status: "confirmed")

med1 = Medicine.create!(
  name: "Paracetamol",
  description: "Pain relief for dogs",
  category: "pill",
  instructions: "Give once a day after meals"
)

med2 = Medicine.create!(
  name: "Antibiotic",
  description: "General infection treatment",
  category: "pill",
  instructions: "Give twice a day, morning and night"
)

Prescription.create!(
  medicine: med1,
  dosage: "100mg",
  special_instructions: "Give once a day after meals",
  appointment: appt1,
  start_date: Time.zone.parse("2025-12-01 10:00"),
  end_date: Time.zone.parse("2025-12-07 10:00")
)

Prescription.create!(
  medicine: med2,
  dosage: "50mg",
  special_instructions: "Give twice a day, morning and night",
  appointment: appt2,
  start_date: Time.zone.parse("2025-12-02 10:00"),
  end_date: Time.zone.parse("2025-12-09 10:00")
)

puts "Seeding completed!"
