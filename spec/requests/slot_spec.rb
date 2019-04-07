require 'rails_helper'

RSpec.describe 'Slots API', type: :request do
  let!(:slots) { create_list(:slot, 10) }


  describe 'GET /candidate_schedules' do

    it 'returns slots' do

      get '/slots/candidate_schedules', params: { slot: { count: nil } }

      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).length).to eq(10)
    end

    it 'returns status code 200' do
      get '/slots/candidate_schedules', params: { slot: { count: nil } }
      expect(response).to have_http_status(200)
    end


    it 'returns number of slots from the params passed in' do
      get '/slots/candidate_schedules', params: { slot: { count: 5 } }
      expect(JSON.parse(response.body).length).to eq(5)
    end
  end

  describe 'POST /schedule_interview' do
    context 'when slot does not exist' do
      let(:slot_id) { 0 }
      
      it 'returns status code 404' do
        post '/slots/schedule_interview', params: { slot: { id: slot_id } }
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        post '/slots/schedule_interview', params: { slot: { id: slot_id } }
        expect(response.body).to match(/Couldn't find Slot/)
      end
    end

    context 'availability date not found' do
      let(:slot) { create(:slot) }
      let(:time) { Date.today-3.days }

      it 'returns scheduled interview time' do
        post '/slots/schedule_interview', params: { slot: { id: slot.id, time: time } }
        expect(response.body).to match(/Canidate not available for given date/)
      end
    end

    context 'availability time not found' do
      let(:slot) { create(:slot) }
      let(:outside_window_time) { Time.zone.now - 2.hours }

      it 'returns scheduled interview time' do
        post '/slots/schedule_interview', params: { slot: { id: slot.id, time: outside_window_time } }
        expect(response.body).to match(/Canidate not available for given time/)
      end
    end

    context 'successfully scheduled interview' do
      let(:slot) { create(:slot, start_time: Time.local(2008, 7, 8, 2, 00), end_time: Time.local(2008, 7, 8, 3, 30)) }
      let(:time) { Time.local(2008, 7, 8, 3, 00) }

      it "will schedule the interview" do
        post '/slots/schedule_interview', params: { slot: { id: slot.id, time: time } }
        expect(response.body).to match(/Your interview has been scheduled/)
      end
    end
  end
end
