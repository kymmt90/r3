class FeedCategorizationsController < ApplicationController
  before_action :check_logged_in
  before_action :check_correct_user
  before_action :set_feed, except: [:index]

  def index
    @categories = current_user.categories.all
  end

  def create
    @categorization = @feed.feed_categorizations.build(category_id: params[:category_id])
    if @categorization.save
      redirect_to user_feed_categorizations_path(current_user)
    else
      flash.now[:danger] = 'Failed'
      render 'new'
    end
  end

  def destroy
    categorization = @feed.feed_categorizations.find_by(category_id: params[:category_id])
    categorization.destroy
    redirect_to user_feed_categorizations_path(current_user)
  end


  private

  def check_correct_user
    user = User.find_by(id: params[:user_id])
    redirect_to root_url unless current_user?(user)
  end

  def set_feed
    @feed = Feed.find(params[:feed_id])
  end
end
