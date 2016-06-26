require 'rails_helper'

feature 'User' do
  feature 'without logging in' do
    scenario 'signs up' do
      visit root_path
      click_link 'Sign up'

      expect {
        fill_in 'Name', with: 'foo'
        fill_in 'Email', with: 'foo@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Submit'
      }.to change(User, :count).by(1)

      expect(current_path).to eq user_path(User.find_by(email: 'foo@example.com'))
      expect(page).to have_content 'User created'
      within 'h1' do
        expect(page).to have_content 'foo'
      end
      expect(page).to have_content 'foo@example.com'
    end

    scenario 'logs in' do
      user = create(:user, email: 'foo@example.com', password: 'password', password_confirmation: 'password')
      visit root_path
      click_link 'Log in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      expect(page).to have_content 'Welcome'
    end

    scenario 'fails to log in' do
      visit root_path
      click_link 'Log in'
      click_button 'Log in'

      expect(page).to have_content 'Invalid email/password combination'
      visit root_path
      expect(page).not_to have_content 'Invalid email/password combination'
    end

    scenario 'access a page for log-in user only without logging in' do
      feed = create(:feed)
      visit feed_path(feed)
      expect(page).to have_content 'Please log in'
    end
  end

  feature 'with logging in' do
    background do
      @user = create(:user)
      log_in @user
    end

    scenario 'edits a profile' do
      click_link "#{@user.name} <#{@user.email}>"
      fill_in 'Name', with: 'foo'
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Submit'

      @user.reload
      expect(@user.name).to eq 'foo'
      expect(page).to have_content 'User profile updated'
    end

    scenario 'adds a new category' do
      click_link 'Categories'
      click_link 'Create new category'
      fill_in 'Name', with: 'category1'
      click_button 'Submit'

      expect(page).to have_content 'category1'
      expect(page).to have_content 'Category created'
    end

    scenario 'edits a category' do
      category = create(:category, user_id: @user.id)

      click_link 'Categories'
      click_link 'edit'
      fill_in 'Name', with: 'Category foo'
      click_button 'Submit'

      expect(page).to have_content 'Category foo'
    end

    scenario 'fails to edit a category' do
      category = create(:category, user_id: @user.id)

      click_link 'Categories'
      click_link 'edit'
      fill_in 'Name', with: ''
      click_button 'Submit'

      expect(page).to have_content 'Fails to update category'
      visit root_path
      expect(page).not_to have_content 'Fails to update category'
    end

    scenario 'fails to add a feed to a category' do
      category = create(:category, user_id: @user.id)
      feed = create(:feed)
      create(:subscription, user_id: @user.id, feed_id: feed.id)
      create(:feed_categorization, feed_id: feed.id, category_id: category.id)

      click_link 'Categories'
      click_link 'Add feed'
      click_button 'Submit'

      expect(page).to have_content 'Failed'
      visit root_path
      expect(page).not_to have_content 'Failed'
    end

    scenario 'subscribes a new feed' do
      feed = create(:feed)

      click_link 'Subscriptions'
      click_link 'Add new feed'
      fill_in 'Feed url', with: feed.feed_url
      click_button 'Submit'

      expect(page).to have_content feed.title
      expect(page).to have_content "\"#{feed.title}\" subscribed"
    end

    scenario 'fails to subscribe a new feed' do
      click_link 'Subscriptions'
      click_link 'Add new feed'
      click_button 'Submit'

      expect(page).to have_content 'The requested feed was not found'
      visit root_path
      expect(page).not_to have_content 'The requested feed was not found'
    end
  end
end
