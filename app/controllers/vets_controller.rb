class VetsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_vet!, only: [:index, :edit, :update]

  def index
    if current_user.vet?
      @vet = current_user
      @availabilities = @vet.availabilities
      @pets_appointments = @vet.availabilities.includes(:appointments)
      render :profile
    else
      @vets = User.where(role: :vet)
      @vets = @vets.search_by_specialty(params[:specialty]) if params[:specialty].present?
      @vets = @vets.search_by_city(params[:city]) if params[:city].present?
    end
  end

  def show
    @vet = User.find(params[:id])
    redirect_to vets_path, alert: "This user is not a vet." unless @vet.vet?
  end

  def edit
    @vet = current_user
  end

  def update
    @vet = current_user
    if @vet.update(vet_params)
      redirect_to vets_path, notice: "Vet profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def vet_params
    params.require(:user).permit(:email, :specialty, :clinic_name, :city, :phone)
  end

  def ensure_vet!
    redirect_to root_path, alert: "Access denied" unless current_user.vet?
  end
end
