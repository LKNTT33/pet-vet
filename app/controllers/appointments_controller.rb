class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_availability, only: [:new, :create]
  before_action :ensure_user!

  def index
    # Show current user's appointments
    @appointments = Appointment.includes(:availability, :pet)
                               .where(pets: { user_id: current_user.id })
  end

  def new
    @availability = Availability.find(params[:availability_id])
    @vet = @availability.user
    @pets = current_user.pets

    @appointment = Appointment.new(
      availability: @availability,
      slot_start: params[:slot_start],
      slot_end: params[:slot_end]
    )
  end


  def create
    @appointment = current_user.appointments.new(appointment_params)

    if @appointment.save
      redirect_to pets_path, notice: "Appointment booked successfully!"
    else
      # In case of failure, redirect back to pet selection with alert
      redirect_to pets_path(
        availability_id: @appointment.availability_id,
        slot_start: @appointment.slot_start,
        slot_end: @appointment.slot_end
      ), alert: "Could not book appointment."
    end
  end


  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path, status: :see_other
  end

  private

  def set_availability
    @availability = Availability.find(params[:availability_id])
  end

  def appointment_params
    params.require(:appointment).permit(:availability_id, :slot_start, :slot_end, :status, :pet_id)
  end

  def ensure_user!
    redirect_to root_path, alert: "You" if current_user.vet?
  end
end
