class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user!

  def index
     @owner_appointments = Appointment.includes(:availability, :pet).where(pets: { user_id: current_user.id })
     @vet_appointments = Appointment.includes(:pet, availability: :user).where(availabilities: { user_id: current_user.id }).joins(:availability)
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
    pet = current_user.pets.find(appointment_params[:pet_id])
    @appointment = pet.appointments.build(appointment_params.merge(
    availability_id: params[:availability_id]
    ))

    if @appointment.save
      redirect_to appointments_path, notice: "Appointment booked successfully!"
    else
      @availability = Availability.find(params[:availability_id])
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

  def appointment_params
    params.require(:appointment).permit(:availability_id, :slot_start, :slot_end, :status, :pet_id)
  end

  def ensure_user!
    redirect_to root_path, alert: "You" if current_user.vet?
  end
end
