class UsersController < ApplicationController
  before_action :check_logged_in, except: [:new, :create]
  before_action :check_correct_user, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created'
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'User updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User deleted'
    redirect_to root_url
  end


  private

  def check_correct_user
    user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(user)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
