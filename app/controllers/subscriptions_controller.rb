class SubscriptionsController < ApplicationController
  def index
    @subscriptions = current_user.subscriptions.all
  end

  def new
    @subscription = current_user.subscriptions.build(user_id: current_user.id)
  end

  def create
    @feed = Feed.fetch(params[:feed_url])
    if @feed.nil?
      flash.now[:danger] = "The requested feed was not found"
      @subscriptions = current_user.subscriptions.all
      render 'index'
      return
    end

    @subscription = current_user.subscriptions.build(user_id: current_user.id,
                                                     feed_id: @feed.id)
    if @subscription.save
      flash[:success] = "\"#{@feed.title}\" subscribed"
      redirect_to user_subscriptions_path(current_user)
    else
      flash.now[:danger] = "Failed to subscribe"
      @subscriptions = current_user.subscriptions.all
      render 'index'
    end
  end

  def destroy
    subscription = current_user.subscriptions.find_by(feed_id: params[:id])
    subscription.destroy

    feed = Feed.find_by(id: params[:id])
    flash[:success] = "\"#{feed.title}\" unsubscribed"
    redirect_to user_subscriptions_path(current_user)
  end
end
