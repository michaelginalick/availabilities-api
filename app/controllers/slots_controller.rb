class SlotsController < ApplicationController

  def candidate_schedules
    slots = Slot.scope(slot_params[:count])

    json_response(slots)
  end



  private

  def slot_params
    params.require(:slot).permit(:count, :id, :time)
  end

end
