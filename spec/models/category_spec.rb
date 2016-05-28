require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'valid category' do
    it 'is valid' do
      expect(build(:category)).to be_valid
    end
  end

  describe 'invalid category' do
    it 'is invalid without a name' do
      expect(build(:category, name: nil)).not_to be_valid
    end

    it 'is invalid with a long name' do
      expect(build(:category, name: 'a' * 21)).not_to be_valid
    end
  end
end
