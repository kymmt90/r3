require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }

  before do
    session[:user_id] = user.id
  end

  describe 'GET #show' do
    let(:entry) { create(:entry, feed_id: feed.id) }

    before do
      30.times do
        create(:entry, feed_id: feed.id)
      end
    end

    it 'renders the :show template' do
      get :show, feed_id: feed.id, id: entry.id
      expect(response).to render_template :show
    end

    it 'assigns the requested entry to @entry' do
      get :show, feed_id: feed.id, id: entry.id
      expect(assigns(:entry)).to eq entry
    end
  end
end
