class CategoriesController < ApplicationController
  before_action :set_category, only: [:update, :destroy]

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category created'
      redirect_to @category.user
    else
      redirect_to root_url
    end
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = 'Category updated'
      redirect_to @category.user
    else
      redirect_to root_url
    end
  end

  def destroy
    @category.destroy
    redirect_to root_url
  end


  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :user_id)
  end
end
