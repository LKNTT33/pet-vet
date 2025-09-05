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
    taken_slots = appointment.present? ? [[appointment.slot_start, appointment.slot_end]] : []
    slots(duration).reject { |s| taken_slots.include?([s[:start], s[:end]]) }
  end
end
