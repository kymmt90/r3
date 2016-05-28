require 'rails_helper'

RSpec.describe FeedCategorization, type: :model do
  describe 'valid feed categorization' do
    it 'is valid' do
      expect(build(:feed_categorization)).to be_valid
    end
  end

  describe 'invalid feed categorization' do
    it 'is invalid without a feed' do
      categorization = build(:feed_categorization, feed: nil)
      expect(categorization).not_to be_valid
    end

    it 'is invalid without a category' do
      categorization = build(:feed_categorization, category: nil)
      expect(categorization).not_to be_valid
    end
  end
end
