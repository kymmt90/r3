class CategoriesController < ApplicationController
  before_action :check_logged_in
  before_action :set_category, only: [:edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(name: params[:category][:name], user_id: current_user.id)
    if @category.save
      flash[:success] = 'Category created'
      redirect_to user_feed_categorizations_url(current_user)
    else
      redirect_to root_url
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(name: params[:category][:name])
      flash[:success] = 'Category updated'
      redirect_to user_feed_categorizations_url(current_user)
    else
      flash.now[:danger] = 'Fails to update category'
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to user_feed_categorizations_url(current_user)
  end


  private

  def set_category
    @category = Category.find(params[:id])
  end
end
