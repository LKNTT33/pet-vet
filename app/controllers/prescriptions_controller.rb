class PrescriptionsController < ApplicationController
  before_action :set_pet
  before_action :set_appointment
  #before_action :ensure_vet!, only: [:new, :create]

  def index
    @prescriptions = @appointment.prescriptions
  end

  def show
    @prescription = @appointment.prescriptions.find(params[:id])
  end

  def new
    @prescription = Prescription.new
    @medicines = Medicine.all
  end

  def create
    @prescription = @appointment.prescriptions.build(prescription_params)

    if @prescription.save
      redirect_to pet_appointment_prescription_path(@pet, @appointment, @prescription),
                  notice: "Prescription created successfully!"
    else
      @medicines = Medicine.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def set_appointment
    @appointment = @pet.appointments.find(params[:appointment_id])
  end

  def prescription_params
    params.require(:prescription).permit(
      :medicine_id,
      :dosage,
      :special_instructions,
      :start_date,
      :end_date
    )
  end
end
