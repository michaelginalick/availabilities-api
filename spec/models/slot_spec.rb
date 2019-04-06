require 'rails_helper'

RSpec.describe Slot, type: :model do
  
  describe "validations" do
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
  end

  let!(:slots) { create_list(:slot, 10) }

  describe "#scope" do
    it "will limit the number of records returned" do
      expect(Slot.scope(5).length).to eq(5)
    end

    it "will limit the number of records returned" do
      expect(Slot.scope(nil).length).to eq(10)
    end
  end
end
