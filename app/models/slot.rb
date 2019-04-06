class Slot < ApplicationRecord

  validates :start_time, :end_time, presence: true

  def self.scope(count)
    return Slot.all unless count.present?
    Slot.limit(count)
  end
  
end
