require 'rails_helper'

RSpec.describe ReadingStatusesController, type: :controller do
  let(:user) { create(:user) }

  describe 'not logging in' do
    describe 'PATCH reading_statuses#update' do
      let(:entry) { create(:entry) }
      before do
        @status = user.reading_statuses.create(entry_id: entry.id, status: :unread)
      end

      it 'redirects to the login URL' do
         patch :update,
                id: @status,
                user_id: user,
                entry_id: entry,
                reading_status: :read
         expect(response).to redirect_to login_url
      end
    end
  end

  describe 'logging in' do
    before do
      session[:user_id] = user.id
    end

    describe 'PATCH reading_statuses#update' do
      let(:entry) { create(:entry) }
      before do
        @status = user.reading_statuses.create(entry_id: entry.id, status: :unread)
      end

      context 'with valid attributes' do
        it 'changes the status' do
          patch :update,
                id: @status,
                user_id: user,
                entry_id: entry,
                reading_status: :read
          @status.reload
          expect(@status.status).to eq 'read'
        end

        it 'returns http success' do
          patch :update,
                id: @status,
                user_id: user,
                entry_id: entry,
                reading_status: :read
          @status.reload
          expect(response).to have_http_status(:success)
        end
      end

      context 'with invalid attributes' do
        it 'returns http error' do
          patch :update,
                id: @status,
                user_id: user,
                entry_id: nil,
                reading_status: :read
          expect(response).to have_http_status(:error)
        end
      end

      context 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          patch :update,
                id: @status,
                user_id: other_user,
                entry_id: entry,
                reading_status: :read
          expect(response).to redirect_to root_url
        end
      end
    end
  end
end
