class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_user!

  def show
    @user = current_user
    @pets = @user.pets
    @appointments = @user.pets.includes(:appointments).map(&:appointments).flatten
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
  end
end


  private

  def user_params
    params.require(:user).permit(:email, :phone, :city)
  end

  # def ensure_user!
  #   redirect_to root_path, alert: "Access denied" if current_user.vet?
  # end
end
