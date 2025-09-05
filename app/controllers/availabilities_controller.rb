class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vet
  before_action :authorize_vet!, only: [:new, :create, :destroy]

  # Define order of weekdays
  DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday]

  # GET /vets/:vet_id/availabilities
  def index
    @availabilities = @vet.availabilities
                          .where.not(day_of_week: nil, start_time: nil)
    @availabilities = @availabilities.where(day_of_week: params[:day_of_week]) if params[:day_of_week].present?
    @availabilities = @availabilities.sort_by { |a| [DAYS.index(a.day_of_week), a.start_time] }
  end

  # GET /vets/:vet_id/availabilities/new
  def new
    @availability = @vet.availabilities.new
    @availabilities = @vet.availabilities
                          .where.not(day_of_week: nil, start_time: nil)
                          .sort_by { |a| [DAYS.index(a.day_of_week), a.start_time] }
  end

  # POST /vets/:vet_id/availabilities
  def create
    @availability = @vet.availabilities.build(availability_params)
    if @availability.save
      @availabilities = @vet.availabilities
                            .where.not(day_of_week: nil, start_time: nil)
                            .sort_by { |a| [DAYS.index(a.day_of_week), a.start_time] }
      flash.now[:notice] = "Availability created successfully!"
      render :new
    else
      @availabilities = @vet.availabilities
                            .where.not(day_of_week: nil, start_time: nil)
                            .sort_by { |a| [DAYS.index(a.day_of_week), a.start_time] }
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /vets/:vet_id/availabilities/:id
  def destroy
    @availability = @vet.availabilities.find(params[:id])
    @availability.destroy
    flash.now[:notice] = "Availability deleted successfully!"
    @availabilities = @vet.availabilities
                          .where.not(day_of_week: nil, start_time: nil)
                          .sort_by { |a| [DAYS.index(a.day_of_week), a.start_time] }
    render :new
  end

  private

  # Only allow permitted fields
  def availability_params
    params.require(:availability).permit(:day_of_week, :start_time, :end_time)
  end

  # Load the vet from nested route
  def set_vet
    @vet = User.find(params[:vet_id])
    redirect_to vets_path, alert: "This user is not a vet." unless @vet.vet?
  end

  # Ensure current_user is the vet
  def authorize_vet!
    redirect_to root_path, alert: "Not authorized" unless @vet == current_user
  end
end
