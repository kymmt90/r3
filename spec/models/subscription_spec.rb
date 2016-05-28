require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'valid subscription' do
    it 'is valid' do
      expect(build(:subscription)).to be_valid
    end
  end

  describe 'invalid subscription' do
    it 'is invalid without a feed' do
      subscription = build(:subscription, feed: nil)
      expect(subscription).not_to be_valid
    end

    it 'is invalid without a user' do
      subscription = build(:subscription, user: nil)
      expect(subscription).not_to be_valid
    end
  end
end
