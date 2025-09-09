class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.owner?
      @owner_appointments = Appointment.includes(:availability, :pet).where(pets: { user_id: current_user.id })
    end
    if current_user.vet?
     @vet_appointments = Appointment.includes(:pet, availability: :user).where(availabilities: { user_id: current_user.id }).joins(:availability)
    end
  end

  # GET /appointments/new
  def new
    @availability = Availability.find(params[:availability_id])
    @vet = @availability.user
    @pets = current_user.pets
    @appointment = Appointment.new(
      availability: @availability,
      slot_start: params[:slot_start],
      slot_end: params[:slot_end],
      pet_id: params[:pet_id]
    )
  end

  # POST /appointments
  def create
    @appointment = current_user.appointments.new(appointment_params)

    if @appointment.save
      redirect_to appointments_path, notice: "Appointment booked successfully!"
    else
      flash.now[:alert] = "Could not book appointment."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path, status: :see_other, notice: "Appointment cancelled successfully."
  end

  private

  def set_vet
    @vet = User.find(params[:vet_id]) if params[:vet_id].present?
  end

  def appointment_params
    params.require(:appointment).permit(:availability_id, :slot_start, :slot_end, :pet_id)
  end
end
