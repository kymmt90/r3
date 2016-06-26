require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }

  before do
    session[:user_id] = user.id
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:category, user_id: user.id) }

      it 'saves the new category in the database' do
        expect {
          post :create, category: valid_attributes
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the feed_categorizations#index' do
        post :create, category: valid_attributes
        expect(response).to redirect_to user_feed_categorizations_url(user)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { attributes_for(:invalid_category, user_id: user.id) }

      it 'does not save the new category in the database' do
        expect {
          post :create, category: invalid_attributes
        }.not_to change(Category, :count)
      end

      it 'redirects to the root' do
        post :create, category: invalid_attributes
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'PATCH #update' do
    let(:category) { create(:category, name: 'Foo', user_id: user.id) }

    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:category, user_id: user.id) }

      it 'assigns the requested category to @category' do
        patch :update, id: category, category: valid_attributes
        expect(assigns(:category)).to eq category
      end

      it 'redirects to the feed_categorizations#index' do
        patch :update, id: category, category: valid_attributes
        expect(response).to redirect_to user_feed_categorizations_url(user)
      end

      it 'changes attributes of the category' do
        patch :update, id: category, category: attributes_for(:category, name: 'Bar', user_id: user.id)
        category.reload
        expect(category.name).to eq 'Bar'
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { attributes_for(:invalid_category, user_id: user.id) }

      it 'does not change attributes of the category' do
        patch :update, id: category, category: invalid_attributes
        category.reload
        expect(category.name).to eq 'Foo'
      end

      it 'redirects to the root' do
        patch :update, id: category, category: invalid_attributes
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:category) { create(:category, user_id: user.id) }

    it 'assigns the requested category to @category' do
      delete :destroy, id: category
      expect(assigns(:category)).to eq category
    end

    it 'deletes the category' do
      expect {
        delete :destroy, id: category
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to feed_categorizations#index' do
      delete :destroy, id: category
      expect(response).to redirect_to user_feed_categorizations_url(user)
    end
  end
end
