class InterviewService

  attr_reader :slot, :time

  def initialize(slot, time)
    @slot = slot
    @time = time
    verify_date
    verify_time_window
  end

  def  verify_interview_time
    true
  end
  
  private
  
  def verify_date
    raise UnavailableDayError if time.day != slot.start_time.day
  end

  def verify_time_window
    raise UnavailableTimeError unless (slot.start_time.utc..slot.end_time.utc).cover?((time + 30.minutes).utc)
  end

end
