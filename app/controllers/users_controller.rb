class UsersController < ApplicationController
  def index
    @users = User.where(role: :vet)

    if params[:specialty].present?
      @users = @users.search_by_specialty(params[:specialty])
    end

    if params[:city].present?
      @users = @users.search_by_city(params[:city])
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Not a vet" unless @user.role == "vet"
  end
end
