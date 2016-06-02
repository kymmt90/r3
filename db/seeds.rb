require 'factory_girl_rails'

user1 = FactoryGirl.create(:user, name: 'Foo', email: 'foo@example.com')
user2 = FactoryGirl.create(:user, name: 'Bar', email: 'bar@example.com')

feed1 = FactoryGirl.create(:feed, url: 'http://example.com/feed1.xml')
feed2 = FactoryGirl.create(:feed, url: 'http://example.com/feed2.xml')
FactoryGirl.create(:feed, url: 'http://example.com/feed3.xml')

30.times do
  FactoryGirl.create(:entry, feed_id: feed1.id)
  FactoryGirl.create(:entry, feed_id: feed2.id)
end

2.times do
  FactoryGirl.create(:category, user_id: user1.id)
  FactoryGirl.create(:category, user_id: user2.id)
end

FactoryGirl.create(:subscription, user_id: user1.id, feed_id: feed1.id)
FactoryGirl.create(:subscription, user_id: user1.id, feed_id: feed2.id)
FactoryGirl.create(:subscription, user_id: user2.id, feed_id: feed1.id)
