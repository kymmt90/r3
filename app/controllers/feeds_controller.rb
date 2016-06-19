class FeedsController < ApplicationController
  before_action :check_logged_in
  before_action :set_feed, only: [:show, :destroy, :refresh]

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.save
    redirect_to root_url
  end

  def destroy
    @feed.destroy
    redirect_to root_url
  end

  def refresh
    @feed.refresh
    @feed.initialize_reading_statuses(current_user)
    redirect_to @feed
  end


  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:feed_url, :url, :title, :unread_only)
  end
end
