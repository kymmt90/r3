require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'renders the :show template' do
      get :show, id: user
      expect(response).to render_template :show
    end

    it 'assigns the requested user to @user' do
      get :show, id: user
      expect(assigns(:user)).to eq user
    end
  end

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
    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:user) }

      it 'saves the new user in the database' do
        expect {
          post :create, user: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'redirects to users#show' do
        post :create, user: valid_attributes
        expect(response).to redirect_to user_path(assigns(:user))
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { attributes_for(:invalid_user) }

      it 'does not save the new user in the database' do
        expect {
          post :create, user: invalid_attributes
        }.not_to change(User, :count)
      end

      it 're-renders the :new template' do
        post :create, user: invalid_attributes
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }

    it 'renders the :edit template' do
      get :edit, id: user
      expect(response).to render_template :edit
    end

    it 'assigns the requested user to @user' do
      get :edit, id: user
      expect(assigns(:user)).to eq user
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user, name: 'foo', email: 'foo@example.com') }

    context 'with valid attributes' do
      it 'assigns the requested users to @user' do
        patch :update, id: user, user: attributes_for(:user)
        expect(assigns(:user)).to eq user
      end

      it 'redirects to the updated user' do
        patch :update, id: user, user: attributes_for(:user)
        expect(response).to redirect_to user
      end

      it "changes @contact's attributes" do
        patch :update, id: user, user: attributes_for(:user, name: 'bar')
        user.reload
        expect(user.name).to eq 'bar'
      end
    end

    context 'with invalid attributes' do
      it "does not change the user's attributes" do
        patch :update, id: user, user: attributes_for(:invalid_user)
        user.reload
        expect(user.name).to eq 'foo'
      end

      it 're-renders the :edit template' do
        patch :update, id: user, user: attributes_for(:invalid_user)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'assigns the requested user to @user' do
      delete :destroy, id: user
      expect(assigns(:user)).to eq user
    end

    it 'deletes the user' do
      expect {
        delete :destroy, id: user
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the root URL' do
      delete :destroy, id: user
      expect(response).to redirect_to root_url
    end
  end
end
