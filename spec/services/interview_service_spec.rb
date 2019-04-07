require 'rails_helper'

RSpec.describe 'Interview Service', type: :service do

  context "errors" do
    let(:slot) { create(:slot) }
    let(:bad_day) { 2.hours.from_now.hour }
    let(:outside_window_time) { (Time.zone.now - 1.hours) }
    
    it "will throw an error if days do not match" do
      expect { InterviewService.new(slot, bad_day) }.to raise_error(UnavailableDayError)
    end
    
    it "will throw an error if the time is not in the specified window" do
      expect { InterviewService.new(slot, outside_window_time) }.to raise_error(UnavailableTimeError)
    end
  end

  context "success" do
    let(:slot) { create(:slot, start_time: Time.local(2008, 7, 8, 2, 00), end_time: Time.local(2008, 7, 8, 3, 30)) }
    let(:time) { Time.local(2008, 7, 8, 3, 00) }

    it "will return the scheduled interview time" do
      expect(InterviewService.new(slot, time).verify_interview_time).to eq(true)
    end

  end

end
