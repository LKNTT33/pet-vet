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

  def new
    @appointment = Appointment.new(
      availability_id: params[:availability_id],
      slot_start: params[:slot_start],
      slot_end: params[:slot_end],
      pet_id: params[:pet_id]
    )

    @vet = Availability.find(params[:availability_id]).user if params[:availability_id].present?
    @availability = Availability.find(params[:availability_id]) if params[:availability_id].present?
    @pet = current_user.pets.find_by(id: params[:pet_id]) if params[:pet_id].present?
    @pets = current_user.pets
  end

  def create
    pet = current_user.pets.find(appointment_params[:pet_id])
    # @appointment = pet.appointments.build(appointment_params.merge(
    #   availability_id: params[:availability_id]
    #   ))
    @appointment = Appointment.new(appointment_params)
    # @appointment.user = current_user
      # @appointment = current_user.appointments.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, notice: "Appointment booked successfully!"
    else
      flash.now[:alert] = "Could not book appointment."
      render :new, status: :unprocessable_entity,
      locals: {vet: @appointment.availability.vet, availability: @appointment.availability}
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
