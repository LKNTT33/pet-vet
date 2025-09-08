class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vet
  before_action :authorize_vet!, only: [:new, :create, :destroy]

  def index
    @availabilities = @vet.availabilities.order(:start_time)

    if params[:date].present?
      begin
        selected_date = Date.parse(params[:date])
        @availabilities = @availabilities.where(date: selected_date)
      rescue ArgumentError
        flash.now[:alert] = "Invalid date"
      end
    end

    respond_to do |format|
      format.html # default HTML view
      format.json do
        # JSON for dynamic calendar
        render json: @availabilities.map { |a|
          a.slots.map do |slot|
            {
              start: slot[:start],
              end: slot[:end],
              available: !a.appointments.any? { |appt| appt.slot_start == slot[:start] }
            }
          end
        }.flatten
      end
    end
  end

  def new
    @availability = @vet.availabilities.new
    @availabilities = @vet.availabilities.order(:start_time)
  end

  def create
    @availability = @vet.availabilities.new(availability_params)

    # Parse date/time strings into proper types if needed
    @availability.date = Date.parse(availability_params[:date]) if availability_params[:date].present?
    @availability.start_time = Time.zone.parse(availability_params[:start_time]) if availability_params[:start_time].present?
    @availability.end_time = Time.zone.parse(availability_params[:end_time]) if availability_params[:end_time].present?

    if @availability.save
      respond_to do |format|
        format.turbo_stream # renders create.turbo_stream.erb
        format.html { redirect_to new_vet_availability_path(@vet), notice: "Availability added!" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("availability_form", partial: "form", locals: { availability: @availability }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


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
    params.require(:availability).permit(:date, :start_time, :end_time, :is_available)
  end

  def set_vet
    @vet = User.find(params[:vet_id])
    redirect_to vets_path, alert: "This user is not a vet." unless @vet.vet?
  end

  def authorize_vet!
    redirect_to root_path, alert: "Not authorized" unless @vet == current_user
  end
end
