require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns the new user to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with valid session parameters' do
      let(:valid_parameters) do
        { email: user.email, password: user.password }
      end

      it 'saves the user ID in the session' do
        post :create, session: valid_parameters
        expect(session[:user_id]).to eq user.id
      end

      it 'redirects to users#show' do
        post :create, session: valid_parameters
        expect(response).to redirect_to user
      end
    end

    context 'with invalid session parameters' do
      let(:invalid_parameters) do
        { email: user.email, password: 'invalid' }
      end

      it 'does not save the user ID in the session' do
        post :create, session: invalid_parameters
        expect(session[:user_id]).to be_nil
      end

      it 're-renders the :new template' do
        post :create, session: invalid_parameters
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with the logged in user' do
      before do
        user = create(:user)
        session[:user_id] = user.id
      end

      it 'delete the user ID from the session hash' do
        delete :destroy
        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the root' do
        delete :destroy
        expect(response).to redirect_to root_url
      end
    end

    context 'without the logged in user' do
      before { session[:user_id] = nil }

      it 'redirects to the root' do
        delete :destroy
        expect(response).to redirect_to root_url
      end
    end
  end
end
