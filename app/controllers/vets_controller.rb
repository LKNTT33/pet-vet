class VetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @vets = User.where(role: :vet)

    if params[:specialty].present?
      @vets = @vets.search_by_specialty(params[:specialty])
    end

    if params[:city].present?
      @vets = @vets.search_by_city(params[:city])
    end
  end

  def show
    @vet = User.find(params[:id])
    
    unless @vet.vet?
      redirect_to vets_path, alert: "This user is not a vet."
    else
      @availabilities = @vet.availabilities
    end
  end
end
