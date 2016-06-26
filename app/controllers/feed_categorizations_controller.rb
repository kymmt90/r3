class FeedCategorizationsController < ApplicationController
  before_action :check_logged_in
  before_action :check_correct_user

  def index
    @categories = current_user.categories.all
  end

  def new
    @category = Category.find(params[:category_id])
  end

  def create
    @feed = Feed.find(params[:feed])
    @categorization = @feed.feed_categorizations.build(category_id: params[:category_id])
    if @categorization.save
      redirect_to user_feed_categorizations_path(current_user)
    else
      if params[:category_id].nil?
        flash.now[:danger] = 'Failed'
        render 'index'
        return
      end

      @category = Category.find(params[:category_id])
      flash.now[:danger] = "Failed (maybe it has already added to #{@category.name})"
      render 'new'
    end
  end

  def destroy
    categorization = FeedCategorization.find(params[:id])
    categorization.destroy
    redirect_to user_feed_categorizations_path(current_user)
  end


  private

  def check_correct_user
    user = User.find_by(id: params[:user_id])
    redirect_to root_url unless current_user?(user)
  end
end
