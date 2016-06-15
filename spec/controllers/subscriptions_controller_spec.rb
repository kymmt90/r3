require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'not logging in' do
    describe 'GET #index' do
      it 'redirects to login URL' do
        get :index, user_id: user
        expect(response).to redirect_to login_url
      end
    end

    describe 'GET #new' do
      it 'redirects to login URL' do
        get :new, user_id: user
        expect(response).to redirect_to login_url
      end
    end

    describe 'POST #create' do
      it 'redirects to login URL' do
        post :create, user_id: user, feed_url: 'http://blog.kymmt.com/feed'
        expect(response).to redirect_to login_url
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login URL' do
        delete :destroy, id: 1, user_id: user
        expect(response).to redirect_to login_url
      end
    end
  end

  describe 'logging in' do
    before do
      session[:user_id] = user.id
    end

    describe 'GET #index' do
      it 'renders the :index template' do
        get :index, user_id: user
        expect(response).to render_template :index
      end

      it "assigns user's subscriptions to @subscriptions" do
        get :index, user_id: user
        expect(assigns(:subscriptions)).to eq user.subscriptions
      end

      describe 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          get :index, user_id: other_user
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'GET #new' do
      it 'renders the :new template' do
        get :new, user_id: user
        expect(response).to render_template :new
      end

      it "assigns a subscription to @subscription" do
        get :new, user_id: user
        expect(assigns(:subscription)).to be_a_new(Subscription)
      end

      describe 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          get :new, user_id: other_user
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new subscription in the database' do
          VCR.use_cassette('blog.kymmt.com') do
            expect {
              post :create, user_id: user, feed_url: 'http://blog.kymmt.com/feed'
            }.to change(Feed, :count).by(1)
          end
        end

        it 'redirects to subscriptions#index' do
          VCR.use_cassette('blog.kymmt.com') do
            post :create, user_id: user, feed_url: 'http://blog.kymmt.com/feed'
          end
          expect(response).to redirect_to user_subscriptions_path(user)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new subscription in the database' do
          expect {
            post :create,
                 user_id: user,
                 feed_url: "javascript:alert('XSS');//http://example.com/feed"
          }.not_to change(Feed, :count)
        end

        it 're-renders subscriptions#index' do
          post :create,
               user_id: user,
               feed_url: "javascript:alert('XSS');//http://example.com/feed"
          expect(response).to render_template :index
        end
      end

      context 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          post :create, user_id: other_user, feed_url: 'http://blog.kymmt.com/feed'
          expect(response).to redirect_to root_url
        end
      end
    end

    describe 'DELETE #destroy' do
      before do
        VCR.use_cassette('blog.kymmt.com') do
          post :create, user_id: user, feed_url: 'http://blog.kymmt.com/feed'
        end
        @feed = Feed.find_by(feed_url: 'http://blog.kymmt.com/feed').id
      end

      it 'deletes the subscription' do
        expect {
          delete :destroy, id: @feed, user_id: user
        }.to change(Subscription, :count).by(-1)
      end

      it 'redirects to subscriptions#index' do
        expect(response).to redirect_to user_subscriptions_path(user)
      end

      describe 'other user' do
        let(:other_user) { create(:user) }

        it 'redirects to the root URL' do
          delete :destroy, id: @feed, user_id: other_user
          expect(response).to redirect_to root_url
        end
      end
    end
  end
end
