require 'rails_helper'

RSpec.describe FeedCategorizationsController, type: :controller do
  let(:user) { create(:user) }

  before do
    session[:user_id] = user.id
  end

  describe 'GET #index' do
    it 'renders the :index template' do
      get :index, user_id: user
      expect(response).to render_template :index
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
  end
end
