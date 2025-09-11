class Availability < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  validates :day_of_week, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  # Scope to order weekdays Monday → Sunday
  scope :ordered_by_weekday, -> {
    order(Arel.sql("
      CASE day_of_week
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
      END
    "))
  }

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
    taken_slots = appointments.map { |a| [a.slot_start, a.slot_end] } # careful: use slot_start / slot_end
    slots(duration).reject do |s|
      taken_slots.any? { |ts| ts[0] == s[:start] && ts[1] == s[:end] }
    end
  end
end
