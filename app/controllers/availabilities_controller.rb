class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vet
  before_action :authorize_vet!, only: [:new, :create, :destroy]

  # GET /vets/:vet_id/availabilities
  def index
    @availabilities = sorted_availabilities

    # Filter by day_of_week if selected
    if params[:day_of_week].present?
      @availabilities = @availabilities.select do |a|
        # Include if it matches day_of_week or the date's weekday
        a.day_of_week == params[:day_of_week] ||
          (a.date.present? && a.date.strftime("%A") == params[:day_of_week])
      end
    end
  end

  # GET /vets/:vet_id/availabilities/new
  def new
    @availability = @vet.availabilities.new
    @availabilities = sorted_availabilities
  end

  # POST /vets/:vet_id/availabilities
  def create
    @availability = @vet.availabilities.build(availability_params)

    if @availability.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to new_vet_availability_path(@vet), notice: "Availability added!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /vets/:vet_id/availabilities/:id
  def destroy
    @availability = @vet.availabilities.find(params[:id])
    @availability.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to new_vet_availability_path(@vet), notice: "Availability deleted." }
    end
  end

  private

  def availability_params
    params.require(:availability).permit(:date, :day_of_week, :start_time, :end_time)
  end

  def set_vet
    @vet = User.find(params[:vet_id])
    redirect_to vets_path, alert: "This user is not a vet." unless @vet.vet?
  end

  def authorize_vet!
    redirect_to root_path, alert: "Not authorized" unless @vet == current_user
  end

  def sorted_availabilities
    @vet.availabilities
        .where.not(start_time: nil, end_time: nil)
        .order(:date, :start_time)
  end
end
