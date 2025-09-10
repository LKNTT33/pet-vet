class AvailabilitiesController < ApplicationController
  before_action :set_vet
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_vet!, only: [:new, :create, :destroy]
  before_action :authorize_vet!, only: [:new, :create, :destroy]

  def index
    @selected_date = parse_date(params[:date]) || Date.today
    @pet_id = params[:pet_id]

    weekday_name = @selected_date.strftime("%A")
    @slots_for_day = []

    @vet.availabilities.where(day_of_week: weekday_name).each do |availability|
      # Align availability to the selected_date
      start_dt = availability.start_time.change(year: @selected_date.year,
                                                month: @selected_date.month,
                                                day: @selected_date.day)
      end_dt   = availability.end_time.change(year: @selected_date.year,
                                              month: @selected_date.month,
                                              day: @selected_date.day)

      # Use slots method from model
      availability.slots.each do |slot|
        slot_start = slot[:start].change(year: @selected_date.year,
                                         month: @selected_date.month,
                                         day: @selected_date.day)
        slot_end   = slot[:end].change(year: @selected_date.year,
                                       month: @selected_date.month,
                                       day: @selected_date.day)

        taken = Appointment.exists?(availability_id: availability.id,
                                    slot_start: slot_start)

        @slots_for_day << {
          availability_id: availability.id,
          start: slot_start,
          end: slot_end,
          taken: taken
        }
      end
    end

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream.replace(
          "slots",
          partial: "availabilities/slots",
          locals: { slots_for_day: @slots_for_day,
                    selected_date: @selected_date,
                    pet_id: @pet_id,
                    vet: @vet }
        )
      end
    end
  end

  def new
    @availability = @vet.availabilities.new
    @availabilities = @vet.availabilities.ordered_by_weekday
    @preview_week_date = parse_date(params[:date]) || Date.today
  end

  def create
    # Ensure only one availability per weekday per vet
    if availability_params[:day_of_week].present?
      @vet.availabilities.where(day_of_week: availability_params[:day_of_week]).destroy_all
    end

    @availability = @vet.availabilities.build(availability_params)

    if @availability.save
      @availabilities = @vet.availabilities.ordered_by_weekday

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "availabilities_list",
          partial: "availabilities/list",
          locals: { availabilities: @availabilities, vet: @vet }
        )
      }
      format.html { redirect_to new_vet_availability_path(@vet), notice: "Availability created successfully!" }
    end
    else
      @availabilities = @vet.availabilities.ordered_by_weekday
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @availability = @vet.availabilities.find(params[:id])
    @availability.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@availability)) }
      format.html { redirect_to new_vet_availability_path(@vet), notice: "Availability deleted." }
    end
  end

  private

  def availability_params
    params.require(:availability).permit(:day_of_week, :start_time, :end_time, :is_available)
  end

  def set_vet
    @vet = User.find(params[:vet_id])
    redirect_to vets_path, alert: "This user is not a vet." unless @vet&.vet?
  end

  def ensure_vet!
    redirect_to new_user_session_path, alert: "Please log in as a vet." unless current_user&.vet?
  end

  def authorize_vet!
    redirect_to root_path, alert: "Not authorized" unless current_user == @vet
  end

  def parse_date(date_str)
    return nil if date_str.blank?
    Date.parse(date_str) rescue nil
  end

  def dom_id(record)
    "#{record.class.name.underscore}_#{record.id}"
  end
end
