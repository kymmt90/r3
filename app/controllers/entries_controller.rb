class EntriesController < ApplicationController
  before_action :set_feed

  def index
    @entries = @feed.entries
  end

  def show
    @entry = @feed.entries.find(params[:id])
  end


  private

  def set_feed
    @feed = Feed.find(params[:feed_id])
  end
end
