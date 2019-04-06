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
end
