require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe 'valid feed' do
    it 'is valid' do
      expect(build(:feed)).to be_valid
    end
  end

  describe 'invalid feed' do
    it 'is invalid without a title' do
      expect(build(:feed, title: nil)).not_to be_valid
    end

    it 'is invalid without a URL' do
      expect(build(:feed, url: nil)).not_to be_valid
    end

    it 'is invalid with a invalid URL' do
      invalid_url = "javascript:alert('XSS');//http://example.com/"
      expect(build(:feed, url: invalid_url)).not_to be_valid
    end
  end
end
