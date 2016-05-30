require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:feed) { create(:feed) }

  describe 'GET #index' do
    let(:other_feed) { create(:feed) }

    before do
      30.times do
        create(:entry, feed_id: feed.id)
        create(:entry, feed_id: other_feed.id)
      end
    end

    it 'renders the :index template' do
      get :index, feed_id: feed.id
      expect(response).to render_template :index
    end

    it "assigns the feed's entries to @entries" do
      get :index, feed_id: feed.id
      expect(assigns(:entries)).to match_array feed.entries
    end
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
