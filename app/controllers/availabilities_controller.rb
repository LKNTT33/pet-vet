class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vet
  before_action :authorize_vet!, only: [:new, :create, :destroy]

  def index
    if @vet.vet?
      selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.today

      if selected_date.on_weekday?
        day_start = Time.zone.parse("#{selected_date} 09:00")
        day_end   = Time.zone.parse("#{selected_date} 17:00")

        slots = []
        slot_start = day_start

        while slot_start < day_end
          slot_end = slot_start + 30.minutes

          taken = Appointment.exists?(
            slot_start: slot_start,
            slot_end: slot_end,
            availability_id: @vet.availabilities.ids
          )

          slots << {
            date: selected_date,
            start: slot_start,
            end: slot_end,
            taken: taken,
            availability_id: @vet.availabilities.find { |a| a.start_time <= slot_start && a.end_time >= slot_end }&.id
          }

          slot_start = slot_end
        end

        @slots_for_day = slots
        @selected_date = selected_date
      else
        @slots_for_day = []
        flash.now[:alert] = "No slots on weekends."
      end
    else
      @availabilities = @vet.availabilities.order(:start_time)
      if params[:date].present?
        begin
          selected_date = Date.parse(params[:date])
          @availabilities = @availabilities.where(date: selected_date)
        rescue ArgumentError
          flash.now[:alert] = "Invalid date"
        end
      end
    end

    respond_to do |format|
      format.html
      format.json do
        if @vet.vet?
          render json: @slots_for_day.map { |slot|
            {
              start: slot[:start],
              end: slot[:end],
              available: !slot[:taken]
            }
          }
        else
          render json: @availabilities.map { |a|
            a.slots.map do |slot|
              {
                start: slot[:start],
                end: slot[:end],
                available: !a.appointments.any? { |appt| appt.slot_start == slot[:start] },
                availability_id: a.id
              }
            end
          }.flatten
        end
      end
    end
  end

  def new
    @availability = @vet.availabilities.new

    # Pick a date (default today)
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.today

    # Monday–Friday of the selected week
    week_start = @selected_date.beginning_of_week(:monday)
    week_end   = week_start + 4.days

    # Load availabilities for that week
    @availabilities = @vet.availabilities
                          .where(date: week_start..week_end)
                          .order(:date, :start_time)

    # Fallback: show all availabilities if none found
    if @availabilities.empty?
      @availabilities = @vet.availabilities.order(:date, :start_time)
    end
  end

  def create
    @availability = @vet.availabilities.new(availability_params)

    @availability.date = Date.parse(availability_params[:date]) if availability_params[:date].present?
    @availability.start_time = Time.zone.parse(availability_params[:start_time]) if availability_params[:start_time].present?
    @availability.end_time = Time.zone.parse(availability_params[:end_time]) if availability_params[:end_time].present?

    if @availability.save
      respond_to do |format|
        format.turbo_stream
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
    redirect_to vets_path, alert: "This user is not a vet." unless @vet.vet? || @vet.owner?
  end

  def authorize_vet!
    redirect_to root_path, alert: "Not authorized" unless @vet == current_user
  end
end
