require 'rails_helper'

RSpec.describe ReadingStatus, type: :model do
  describe 'valid reading status' do
    it 'is valid' do
      expect(build(:reading_status)).to be_valid
    end
  end

  describe 'invalid reading status' do
    it 'is invalid without a user' do
      reading_status = build(:reading_status, user: nil)
      expect(reading_status).not_to be_valid
    end

    it 'is invalid without a entry' do
      reading_status = build(:reading_status, entry: nil)
      expect(reading_status).not_to be_valid
    end

    it 'is invalid without a status' do
      reading_status = build(:reading_status, status: nil)
      expect(reading_status).not_to be_valid
    end
  end
end
