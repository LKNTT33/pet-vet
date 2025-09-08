class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_availability, only: [:new, :create]

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
    @availability = Availability.find(params[:availability_id])
    pet = current_user.pets.find(appointment_params[:pet_id])
    @appointment = pet.appointments.build(
      availability: @availability,
      slot_start: appointment_params[:slot_start],
      slot_end: appointment_params[:slot_end]
    )

    if @appointment.save
      redirect_to appointments_path, notice: "Appointment booked successfully!"
    else
      @vet = @availability.user
      @pets = current_user.pets
      render :new, status: :unprocessable_entity
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
end
