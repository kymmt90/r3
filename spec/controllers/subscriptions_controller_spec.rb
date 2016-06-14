require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
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
    it 'renders the :new template' do
      get :new, user_id: user
      expect(response).to render_template :new
    end
  end
end
