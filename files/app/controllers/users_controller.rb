class UsersController < ApplicationController

  before_filter :prevent_signed_in_user_registration, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = t('flash.successful_registration')
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def prevent_signed_in_user_registration
      redirect_to root_url if signed_in?
    end

end