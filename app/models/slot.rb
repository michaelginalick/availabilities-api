class Slot < ApplicationRecord

  validates :start_time, :end_time, presence: true

end
