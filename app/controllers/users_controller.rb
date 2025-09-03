class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @pets = @user.pets
    @appointments = @user.pets.includes(:appointments).map(&:appointments).flatten
  end
end
