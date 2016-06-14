require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  let(:user) { create(:user) }

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
end
