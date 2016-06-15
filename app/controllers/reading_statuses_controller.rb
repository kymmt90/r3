class ReadingStatusesController < ApplicationController
  before_action :check_logged_in
  before_action :check_correct_user

  def update
    status = ReadingStatus.find_by(user_id: params[:user_id],
                                   entry_id: params[:entry_id])
    if status && status.update_attributes(status: params[:reading_status])
      head :ok
    else
      head :ng
    end
  end


  private

  def check_correct_user
    user = User.find_by(id: params[:user_id])
    redirect_to root_url unless current_user?(user)
  end
end
