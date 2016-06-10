require 'factory_girl_rails'

user1 = FactoryGirl.create(:user, name: 'Foo', email: 'foo@example.com')
user2 = FactoryGirl.create(:user, name: 'Bar', email: 'bar@example.com')

feed1 = FactoryGirl.create(:feed, url: 'http://example.com', feed_url: 'http://example.com/feed1.xml')
feed2 = FactoryGirl.create(:feed, url: 'http://example.com', feed_url: 'http://example.com/feed2.xml')
FactoryGirl.create(:feed, url: 'http://example.com', feed_url: 'http://example.com/feed3.xml')

30.times do
  entry1 = FactoryGirl.create(:entry, feed_id: feed1.id)
  FactoryGirl.create(:reading_status, entry_id: entry1.id, user_id: user1.id, status: :saved)
  FactoryGirl.create(:reading_status, entry_id: entry1.id, user_id: user2.id, status: :unread)
  entry2 = FactoryGirl.create(:entry, feed_id: feed2.id)
  FactoryGirl.create(:reading_status, entry_id: entry2.id, user_id: user1.id, status: :read)
end

category1 = FactoryGirl.create(:category, user_id: user1.id)
category2 = FactoryGirl.create(:category, user_id: user2.id)
category3 = FactoryGirl.create(:category, user_id: user1.id)
category4 = FactoryGirl.create(:category, user_id: user2.id)

FactoryGirl.create(:subscription, user_id: user1.id, feed_id: feed1.id)
FactoryGirl.create(:subscription, user_id: user1.id, feed_id: feed2.id)
FactoryGirl.create(:subscription, user_id: user2.id, feed_id: feed1.id)

FactoryGirl.create(:feed_categorization, feed_id: feed1.id, category_id: category1.id)
FactoryGirl.create(:feed_categorization, feed_id: feed1.id, category_id: category2.id)
FactoryGirl.create(:feed_categorization, feed_id: feed2.id, category_id: category3.id)
