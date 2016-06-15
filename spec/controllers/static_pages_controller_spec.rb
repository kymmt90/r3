require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'not logging in' do
    describe 'GET #home' do
      it 'renders the :home template' do
        get :home
        expect(response).to render_template :home
      end
    end
  end

  describe 'logging in' do
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.id
    end

    describe 'GET #home' do
      it 'renders the users#show template' do
        get :home
        expect(response).to redirect_to user_url(user)
      end
    end
  end
end
