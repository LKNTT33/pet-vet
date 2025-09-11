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
# 1. Clean the database
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
  address: "Rua de São Nicolau, 14, Lisbon",
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
  address: "8 Bd Godard",
  specialty: "Generalist",
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
  address: "Praça do Comércio, 11, Lisbon",
  specialty: "Ophthalmology",
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
  address: "77 Quai de Bacalan",
  specialty: "Generalist",
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
  address: "Rua da Madalena, 6, Lisbon",
  specialty: "Surgery",
  city: "Lisbon",
  clinic_name: "SurgeryVet Clinic"
)

vet6 = User.create!(
  email: "gabriela@gmail.com",
  password: "vet123",
  first_name: "Gabriela",
  last_name: "Cardoso",
  role: :vet,
  phone: "960777777",
  address: "Avenida 24 de Julho, 21, Lisbon",
  specialty: "Ophthalmology",
  city: "Lisbon",
  clinic_name: "Lisbon Eye Specialists"
)

vet7 = User.create!(
  email: "elisa@gmail.com",
  password: "vet123",
  first_name: "Elisa",
  last_name: "Santos",
  role: :vet,
  phone: "960555555",
  address: "Largo de Camões, 3, Lisbon",
  specialty: "Ophthalmology",
  city: "Lisbon",
  clinic_name: "Lisbon Vision Center"
)

vet8 = User.create!(
  email: "bruno@gmail.com",
  password: "vet123",
  first_name: "Bruno",
  last_name: "Mendes",
  role: :vet,
  phone: "960222222",
  address: "Avenida da Liberdade, 45, Lisbon",
  specialty: "Ophthalmology",
  city: "Lisbon",
  clinic_name: "Lisbon Eye Clinic"
)

vet9 = User.create!(
  email: "lucas@gmail.com",
  password: "vet123",
  first_name: "Lucas",
  last_name: "Dupont",
  role: :vet,
  phone: "0601111111",
  address: "1 Rue Sainte-Catherine, Bordeaux",
  specialty: "Generalist",
  city: "Bordeaux",
  clinic_name: "Bordeaux Vet Center"
)

vet10 = User.create!(
  email: "vet13@gmail.com",
  password: "vet123",
  first_name: "Antoine",
  last_name: "Martin",
  role: :vet,
  phone: "0603333333",
  address: "12 Place de la Bourse, Bordeaux",
  specialty: "Generalist",
  city: "Bordeaux",
  clinic_name: "Bordeaux Animal Clinic"
)

vet11 = User.create!(
  email: "mathieu@gmail.com",
  password: "vet123",
  first_name: "Mathieu",
  last_name: "Girard",
  role: :vet,
  phone: "0607777777",
  address: "14 Rue du Parlement, Bordeaux",
  specialty: "Generalist",
  city: "Bordeaux",
  clinic_name: "VetCare Bordeaux"
)

vet12 = User.create!(
  email: "elodie@gmail.com",
  password: "vet123",
  first_name: "Elodie",
  last_name: "Bernard",
  role: :vet,
  phone: "0601010101",
  address: "24 Rue Porte Dijeaux, Bordeaux",
  specialty: "Generalist",
  city: "Bordeaux",
  clinic_name: "Bordeaux General Vet Clinic"
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

# Pets
pet1 = Pet.create!(
  name: "Carminho",
  species: "Dog",
  age: 3,
  birthdate: Date.new(2022, 7, 8),
  user: owner2
)

pet2 = Pet.create!(
  name: "Paulie",
  species: "Cat",
  age: 4,
  birthdate: Date.new(2021, 4, 21),
  user: owner1
)

pet3 = Pet.create!(
  name: "Luna",
  species: "Cat",
  age: 2,
  birthdate: Date.new(2023, 2, 10),
  user: owner2
)

pet4 = Pet.create!(
  name: "Bobby",
  species: "Dog",
  age: 5,
  birthdate: Date.new(2019, 11, 5),
  user: owner2
)

pet5 = Pet.create!(
  name: "Goldie",
  species: "Fish",
  age: 1,
  birthdate: Date.new(2024, 1, 15),
  user: owner2
)

# Availabilities for each vets (Mon–Fri, 9am–5pm)
[vet1, vet2, vet3, vet4, vet5].each do |vet|
  %w[Monday Tuesday Wednesday Thursday Friday].each do |day|
    Availability.create!(
      user: vet,
      day_of_week: day,
      start_time: Time.zone.parse("09:00"),
      end_time: Time.zone.parse("17:00"),
      is_available: true
    )
  end
end

# Pick a couple of availabilities for each vet
vet1_monday = Availability.find_by(user: vet1, day_of_week: "Monday")
vet1_tuesday = Availability.find_by(user: vet1, day_of_week: "Tuesday")
vet1_wednesday = Availability.find_by(user: vet1, day_of_week: "Wednesday")
vet2_tuesday = Availability.find_by(user: vet2, day_of_week: "Tuesday")
vet2_wednesday = Availability.find_by(user: vet2, day_of_week: "Wednesday")
vet3_wednesday = Availability.find_by(user: vet3, day_of_week: "Wednesday")

appt1 = Appointment.create!(
  pet: pet1,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 10:00"), # 3 days from today
  slot_end:   Time.zone.parse("#{(Date.today + 3).to_s} 10:30"),
  status: "confirmed"
)

appt2 = Appointment.create!(
  pet: pet2,
  availability: vet2_tuesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 11:30"), # 5 days from today
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 12:00"),
  status: "confirmed"
)

appt3 = Appointment.create!(
  pet: pet1,
  availability: vet3_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 7).to_s} 15:00"), # 1 week from today
  slot_end:   Time.zone.parse("#{(Date.today + 7).to_s} 15:30"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet3,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 09:30"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 10:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet4,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 10:30"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 11:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet4,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 11:00"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 11:30"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet4,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 11:30"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 12:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet4,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 11:30"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 12:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet4,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 14:30"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 15:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet4,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 15:00"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 15:30"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet4,
  availability: vet1_monday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 16:30"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 17:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet3,
  availability: vet1_tuesday,
  slot_start: Time.zone.parse("#{(Date.today + 3).to_s} 11:00"),
  slot_end: Time.zone.parse("#{(Date.today + 3).to_s} 11:30"),
  status: "pending"
)

Appointment.create!(
  pet: pet5,
  availability: vet1_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 4).to_s} 14:00"),
  slot_end: Time.zone.parse("#{(Date.today + 4).to_s} 14:30"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet4,
  availability: vet1_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 4).to_s} 15:00"),
  slot_end: Time.zone.parse("#{(Date.today + 4).to_s} 15:30"),
  status: "pending"
)

Appointment.create!(
  pet: pet5,
  availability: vet2_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 13:00"),
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 13:30"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet5,
  availability: vet2_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 13:30"),
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 14:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet5,
  availability: vet2_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 10:30"),
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 11:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet5,
  availability: vet2_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 11:00"),
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 11:30"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet5,
  availability: vet2_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 11:30"),
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 12:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet5,
  availability: vet2_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 14:30"),
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 15:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet5,
  availability: vet2_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 15:30"),
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 16:00"),
  status: "confirmed"
)

Appointment.create!(
  pet: pet5,
  availability: vet2_wednesday,
  slot_start: Time.zone.parse("#{(Date.today + 5).to_s} 16:00"),
  slot_end:   Time.zone.parse("#{(Date.today + 5).to_s} 16:30"),
  status: "confirmed"
)

# Medicines
med1 = Medicine.create!(
  name: "Paracetamol",
  description: "Pain relief for dogs",
  category: "pills",
  instructions: "Give once a day after meals"
)

med2 = Medicine.create!(
  name: "Antibiotic",
  description: "General infection treatment",
  category: "pills",
  instructions: "Give twice a day, morning and night"
)

med3 = Medicine.create!(
  name: "Vaccine1",
  description: "helps in something",
  category: "vaccine",
  instructions: "everyday"
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
