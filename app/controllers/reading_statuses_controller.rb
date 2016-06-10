class ReadingStatusesController < ApplicationController
  before_action :check_logged_in
  before_action :check_correct_user

  def updated
    status = ReadingStatus.find_by(user_id: params[:user_id],
                                   entry_id: params[:entry_id])
    status.update_attributes(reading_status: params[:reading_status])
  end
end
