require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid user' do
    it 'is valid' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'invalid user' do
    it 'is invalid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid with a long name' do
      user = build(:user, name: 'a' * 21)
      expect(user).not_to be_valid
    end

    it 'is invalid without a email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid with a duplicated email' do
      create(:user, email: 'foobar@example.com')
      user = build(:user, email: 'foobar@example.com')
      expect(user).not_to be_valid
    end

    it 'ignores the case of emails' do
      create(:user, email: 'Foobar@example.com')
      user = build(:user, email: 'foobar@example.com')
      expect(user).not_to be_valid
    end

    it 'is invalid without a password' do
      user = build(:user, password: nil, password_confirmation: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid with a blank password' do
      user = build(:user, password: ' ' * 6, password_confirmation: nil)
      expect(user).not_to be_valid
    end

    it 'is invalid with a short password' do
      password = 'a' * 5
      user = build(:user, password: password, password_confirmation: password)
      expect(user).not_to be_valid
    end
  end

  specify 'associated categories should be destroyed' do
    user = create(:user)
    user.categories.create!(name: 'Foo')
    expect {
      user.destroy
    }.to change(Category, :count).by(-1)
  end

  it 'subscribes its feed' do
    user = create(:user)
    feed = user.feeds.create!(feed_url: 'http://example.com/feed', url: 'http://example.com/', title: 'Foo')
    expect(user.subscribe?(feed)).to be_truthy
  end
end
