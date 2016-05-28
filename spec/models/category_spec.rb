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

    it 'is invalid with a duplicated name' do
      user = create(:user)
      create(:category, user: user, name: 'foobar')
      category = build(:category, user: user, name: 'foobar')
      expect(category).not_to be_valid
    end

    it 'ignores the case of names' do
      user = create(:user)
      create(:category, user: user, name: 'foobar')
      category = build(:category, user: user, name: 'Foobar')
      expect(category).not_to be_valid
    end
  end
end
