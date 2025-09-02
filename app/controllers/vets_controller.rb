class VetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @vets = User.where(role: :vet)
  end

  def show
    @vet = User.find(params[:id])
    if @vet.role != "Vet"
      redirect_to vets_path, alert: "This user is not a vet."
    else
      @availabilities = @vet.availabilities
    end
  end
end
