class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome to Blocipedia, #{@user.name}!"
      create_session(@user)
      redirect_to users_upgrade_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end


  def upgrade

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
