class Availability < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy

  def slots(duration = 30.minutes)
    slots = []
    time = start_time

    while (time + duration) <= end_time
      slots << { start: time, end: time + duration }
      time += duration
    end

    slots
  end

  def free_slots(duration = 30.minutes)
    taken_slots = appointments.map { |a| [a.start_time, a.end_time] }
    slots(duration).reject do |s|
      taken_slots.any? { |ts| ts[0] == s[:start] && ts[1] == s[:end] }
    end
  end
end
