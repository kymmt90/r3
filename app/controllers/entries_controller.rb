class EntriesController < ApplicationController
  before_action :check_logged_in

  def show
    @feed = Feed.find(params[:feed_id])
    @entry = @feed.entries.find(params[:id])
    if current_user.subscribe?(@feed)
      @status = @entry.reading_statuses.find_by(user_id: current_user.id)
      @status.update_attributes(status: :read)
    end
  end
end
