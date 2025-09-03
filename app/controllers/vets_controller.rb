class VetsController < ApplicationController
  before_action :authenticate_user!

  # GET /vets
  def index
    if current_user.vet?
      # Show logged-in vet's own profile
      @vet = current_user
      @availabilities = @vet.availabilities
      @pets_appointments = @vet.availabilities.includes(:appointments)
      render :profile  # Render the profile view instead of index
    else
      # Pet owners: show all vets with optional filters
      @vets = User.where(role: :vet)

      if params[:specialty].present?
        @vets = @vets.search_by_specialty(params[:specialty])
      end

      if params[:city].present?
        @vets = @vets.search_by_city(params[:city])
      end
      # Will render index.html.erb by default
    end
  end

  # GET /vets/:id
  def show
    @vet = User.find(params[:id])
    unless @vet.vet?
      redirect_to vets_path, alert: "This user is not a vet."
    else
      @availabilities = @vet.availabilities
    end
  end

  private

  def ensure_vet!
    redirect_to root_path, alert: "Access denied" unless current_user.vet?
  end
end
