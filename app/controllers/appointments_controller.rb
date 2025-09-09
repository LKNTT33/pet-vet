class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vet, only: [:new]

  # GET /appointments/new
  def new
    @appointment = current_user.appointments.new(
      slot_start: params[:slot_start],
      slot_end: params[:slot_end],
      availability_id: params[:availability_id]
    )
    @pets = current_user.pets
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

  private

  def set_vet
    @vet = User.find(params[:vet_id]) if params[:vet_id].present?
  end

  def appointment_params
    params.require(:appointment).permit(:availability_id, :slot_start, :slot_end, :pet_id)
  end
end
