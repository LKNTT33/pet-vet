class PrescriptionsController < ApplicationController
  #before_action :set_pet, except: :new
  before_action :set_appointment, except: [:new, :show]
  #before_action :ensure_vet!, only: [:new, :create]

  def index
    @prescriptions = @appointment.prescriptions
    @pet = @appointment.pet
  end

  def show
    @prescription = Prescription.find(params[:id])
  end

  def new
    @appointment = Appointment.find(params[:appointment_id])
     @pet = @appointment.pet
    @prescription = Prescription.new
    @medicines = Medicine.all
  end

  def create
    @prescription = @appointment.prescriptions.build(prescription_params)

    if @prescription.save
      redirect_to appointment_prescriptions_path(@appointment, @prescription),
                  notice: "Prescription created successfully!"
    else
      @medicines = Medicine.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  #def set_pet
    #@pet = Pet.find(params[:pet_id])
  #end

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

  def prescription_params
    params.require(:prescription).permit(
      :medicine_id,
      :dosage,
      :special_instructions,
      :start_date,
      :end_date,
      :date_of_administration,
      :immunization_coverage
    )
  end
end
