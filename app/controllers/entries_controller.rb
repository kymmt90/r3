class EntriesController < ApplicationController
  before_action :check_logged_in
  before_action :set_feed

  def index
    @entries = @feed.entries
  end

  def show
    @entry = @feed.entries.find(params[:id])
    if current_user.subscribe?(@feed)
      status = @entry.reading_statuses.find_by(user_id: current_user.id)
      status.update_attributes(status: :read)
    end
  end


  private

  def set_feed
    @feed = Feed.find(params[:feed_id])
  end
end
