require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe 'valid feed' do
    it 'is valid' do
      expect(build(:feed)).to be_valid
    end

    it 'is initialized all reading statuses as unread' do
      feed = create(:feed)
      user = create(:user)
      create(:entry, feed: feed)
      feed.initialize_reading_statuses(user)
      user.entries.where(feed: feed).each do |entry|
        expect(entry.reading_statuses.find_by(user: user).unread?).to be_truthy
      end
    end

    describe 'fetching new feed' do
      before do
        VCR.use_cassette('blog.kymmt.com') do
          @feed = Feed.fetch('http://blog.kymmt.com/feed')
        end
      end

      it 'has the right feed URL' do
        expect(@feed.feed_url).to eq 'http://blog.kymmt.com/feed'
      end

      it 'has the right URL' do
        expect(@feed.url).to eq 'http://blog.kymmt.com/'
      end

      it 'has the right title' do
        expect(@feed.title).to eq 'blog.kymmt.com'
      end

      describe 'fetching new entries' do
        it 'has 30 entries' do
          expect(@feed.entries.count).to eq 30
        end
      end
    end

    describe 'refreshing a feed' do
      before do
        VCR.use_cassette('blog.kymmt.com') do
          @feed = Feed.new(feed_url: 'http://blog.kymmt.com/feed', url: '', title: '')
          @feed = @feed.refresh
        end
      end

      it 'has the right feed URL' do
        expect(@feed.feed_url).to eq 'http://blog.kymmt.com/feed'
      end

      it 'has the right URL' do
        expect(@feed.url).to eq 'http://blog.kymmt.com/'
      end

      it 'has the right title' do
        expect(@feed.title).to eq 'blog.kymmt.com'
      end
    end
  end

  describe 'invalid feed' do
    it 'is invalid without a title' do
      expect(build(:feed, title: nil)).not_to be_valid
    end

    it 'is invalid without a URL' do
      expect(build(:feed, url: nil)).not_to be_valid
    end

    it 'is invalid without a feed URL' do
      expect(build(:feed, feed_url: nil)).not_to be_valid
    end

    it 'is invalid with a duplicated feed URL' do
      create(:feed, feed_url: 'http://example.com/feed.xml')
      feed = build(:feed, feed_url: 'http://example.com/feed.xml')
      expect(feed).not_to be_valid
    end

    it 'is invalid with a invalid URL' do
      invalid_url = "javascript:alert('XSS');//http://example.com/"
      expect(build(:feed, url: invalid_url)).not_to be_valid
    end

    it 'is invalid with a invalid feed URL' do
      invalid_url = "javascript:alert('XSS');//http://example.com/"
      expect(build(:feed, feed_url: invalid_url)).not_to be_valid
    end
  end
end
