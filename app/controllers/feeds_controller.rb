class FeedsController < ApplicationController
  before_action :check_logged_in

  def create
    @feed = Feed.new(feed_params)
    @feed.save
    redirect_to root_url
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy
    redirect_to root_url
  end


  private

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
