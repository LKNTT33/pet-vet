class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vet

  def index
    @availabilities = @vet.availabilities.order(:day_of_week, :start_time)
    if params[:day_of_week].present?
      @availabilities = @availabilities.where(day_of_week: params[:day_of_week])
    end
  end

  def new
    @availability = Availability.new
    @availabilities = current_user.availabilities.order(:day_of_week, :start_time)
  end

  def create
    @availability = current_user.availabilities.build(availability_params)
    if @availability.save
      redirect_to new_availability_path, notice: "Availability created successfully!"
    else
      @availabilities = current_user.availabilities.order(:day_of_week, :start_time)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @availability = Availability.find(params[:id])
    @availability.destroy
    redirect_to new_availability_path, status: :see_other
  end

  private

  def availability_params
    params.require(:availability).permit(:day_of_week, :start_time, :end_time)
  end

  def set_vet
    @vet = User.find(params[:vet_id])
    redirect_to vets_path, alert: "This user is not a vet." unless @vet.vet?
  end
end
