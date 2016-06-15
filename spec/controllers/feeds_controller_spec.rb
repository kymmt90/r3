require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  let(:user) { create(:user) }

  describe 'not logging in' do
    describe 'POST #create' do
      let(:valid_attributes) { attributes_for(:feed) }

      it 'redirects to the login URL' do
        post :create, feed: valid_attributes
        expect(response).to redirect_to login_url
      end
    end

    describe 'DELETE #destroy' do
      let(:feed) { create(:feed) }

      it 'redirects to the login URL' do
        delete :destroy, id: feed
        expect(response).to redirect_to login_url
      end
    end

    describe 'PATCH #refresh' do
      let(:feed) { create(:feed) }

      it 'redirects to the login URL' do
        patch :refresh, id: feed
        expect(response).to redirect_to login_url
      end
    end
  end

  describe 'logging in' do
    before do
      session[:user_id] = user.id
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        let(:valid_attributes) { attributes_for(:feed) }

        it 'saves the new feed in the database' do
          expect {
            post :create, feed: valid_attributes
          }.to change(Feed, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) { attributes_for(:invalid_feed) }

        it 'does not save the new feed in the database' do
          expect {
            post :create, feed: invalid_attributes
          }.not_to change(Feed, :count)
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:feed) { create(:feed) }

      it 'assigns the requested feed to @feed' do
        delete :destroy, id: feed
        expect(assigns(:feed)).to eq feed
      end

      it 'deletes the feed' do
        expect {
          delete :destroy, id: feed
        }.to change(Feed, :count).by(-1)
      end
    end

    describe 'PATCH #refresh' do
      before do
        VCR.use_cassette('blog.kymmt.com') do
          @feed = Feed.fetch('http://blog.kymmt.com/feed')
        end
        @feed.entries.destroy(1)
      end

      it 'refreshes its entries list' do
        VCR.use_cassette('blog.kymmt.com') do
          expect {
            patch :refresh, id: @feed
          }.to change(Entry, :count).by(1)
        end
      end
    end
  end
end
