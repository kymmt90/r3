require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'valid entry' do
    it 'is valid' do
      expect(build(:entry)).to be_valid
    end
  end

  describe 'invalid entry' do
    it 'is invalid without a title' do
      expect(build(:entry, title: nil)).not_to be_valid
    end

    it 'is invalid without a URL' do
      expect(build(:entry, url: nil)).not_to be_valid
    end

    it 'is invalid with a invalid URL' do
      invalid_url = "javascript:alert('XSS');//http://example.com/"
      expect(build(:entry, url: invalid_url)).not_to be_valid
    end

    it 'is invalid withtout a published date' do
      expect(build(:entry, published_at: nil)).not_to be_valid
    end
  end
end
