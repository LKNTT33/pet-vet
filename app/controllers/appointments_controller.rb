class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = Appointment.all
  end

  def new
    @availability = Availability.find(params[:availability_id])
    @appointment = Appointment.new(
      availability: @availability,
      slot_start: params[:slot_start],
      slot_end: params[:slot_end]
    )
  end

  def create
    @appointment = current_user.pets.find(params[:pet_id]).appointments.build(appointment_params)
    if @appointment.save
      redirect_to @appointment, notice: "Appointment booked successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:availability_id, :slot_start, :slot_end, :status)
  end
end
