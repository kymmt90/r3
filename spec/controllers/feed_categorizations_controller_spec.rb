require 'rails_helper'

RSpec.describe FeedCategorizationsController, type: :controller do
  let(:user) { create(:user) }

  describe 'not logging in' do
    describe 'GET #index' do
      it 'redirects to login URL' do
        get :index, user_id: user
        expect(response).to redirect_to login_url
      end
    end

    describe 'GET #new' do
      it 'redirects to login URL' do
        get :new, user_id: user
        expect(response).to redirect_to login_url
      end
    end

    describe 'POST #create' do
      it 'redirects to login URL' do
        post :create, user_id: user, feed_url: 'http://blog.kymmt.com/feed'
        expect(response).to redirect_to login_url
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login URL' do
        delete :destroy, id: 1, user_id: user
        expect(response).to redirect_to login_url
      end
    end
  end

  describe 'logging in' do
    before do
      session[:user_id] = user.id
    end

    describe 'GET #index' do
      it 'renders the :index template' do
        get :index, user_id: user
        expect(response).to render_template :index
      end

      it "assigns user's categories to @categories" do
        get :index, user_id: user
        expect(assigns(:categories)).to match_array user.categories
      end

      describe 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          get :index, user_id: other_user
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'GET #new' do
      before do
        @category = user.categories.create!(name: 'Foo')
      end

      it 'renders the :new template' do
        get :new, user_id: user, category_id: @category
        expect(response).to render_template :new
      end

      it 'assigns the specified category to @category' do
        get :new, user_id: user, category_id: @category
        expect(assigns(:category)).to eq @category
      end

      describe 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          get :new, user_id: other_user, category_id: @category
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'POST #create' do
      before do
        @category = user.categories.create!(name: 'foo')
        VCR.use_cassette('blog.kymmt.com') do
          @feed = Feed.fetch('http://blog.kymmt.com/feed')
        end
      end

      context 'with valid attributes' do
        it 'saves the new categorization in the database' do
          expect {
            post :create, user_id: user, category_id: @category, feed: @feed
          }.to change(FeedCategorization, :count).by(1)
        end

        it 'redirects to feed_categorizations#index' do
          post :create, user_id: user, category_id: @category, feed: @feed
          expect(response).to redirect_to user_feed_categorizations_url(user)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new categorization in the database' do
          expect {
            post :create, user_id: user, category_id: nil, feed: @feed
          }.not_to change(FeedCategorization, :count)
        end

        it 're-renders the :index template' do
          post :create, user_id: user, category_id: nil, feed: @feed
          expect(response).to render_template :index
        end
      end

      context 'with an already added feed' do
        before do
          create(:feed_categorization, feed_id: @feed.id, category_id: @category.id)
        end

        it 'does not save the new categorization in the database' do
          expect {
            post :create, user_id: user, category_id: @category, feed: @feed
          }.not_to change(FeedCategorization, :count)
        end

        it 're-renders the :new template' do
          post :create, user_id: user, category_id: @category, feed: @feed
          expect(response).to render_template :new
        end
      end

      context 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          post :create, user_id: other_user, category_id: @category, feed: @feed
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'DELETE #destroy' do
      before do
        @category = user.categories.create!(name: 'foo')
        VCR.use_cassette('blog.kymmt.com') do
          @feed = Feed.fetch('http://blog.kymmt.com/feed')
        end
        @categorization = @feed.feed_categorizations.create!(category: @category)
      end

      it 'deletes the categorization' do
        expect {
          delete :destroy, id: @categorization, user_id: user
        }.to change(FeedCategorization, :count).by(-1)
      end

      it 'redirects to feed_categorizations#index' do
        delete :destroy, id: @categorization, user_id: user
        expect(response).to redirect_to user_feed_categorizations_url(user)
      end

      describe 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          delete :destroy, id: @categorization, user_id: other_user
          expect(response).to redirect_to root_url
        end
      end
    end
  end
end
