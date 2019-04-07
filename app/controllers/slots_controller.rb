class SlotsController < ApplicationController

  def candidate_schedules
    slots = Slot.scope(slot_params[:count])

    json_response(slots)
  end

  def schedule_interview
    slot = Slot.find(slot_params[:id])
    InterviewService.new(slot, DateTime.parse(slot_params[:time])).verify_interview_time
    render status: 200, json: { message: "Your interview has been scheduled for #{DateTime.parse(slot_params[:time])}."}
  end

  private

  def slot_params
    params.require(:slot).permit(:count, :id, :time)
  end

end
