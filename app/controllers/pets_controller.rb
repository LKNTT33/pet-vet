class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def new
    @pet = Pet.new
  end

  def create
    @pet = current_user.pets.build(pet_params)
    if @pet.save
      if params[:availability_id].present? && params[:slot_start].present? && params[:slot_end].present?
        redirect_to pet_path(
          @pet,
          availability_id: params[:availability_id],
          slot_start: params[:slot_start],
          slot_end: params[:slot_end]
        ), notice: "Pet created successfully!"
      else
        redirect_to pet_path(@pet), notice: "Pet created successfully!"
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @pets = current_user.pets
  end

  def show
  end


  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet, notice: "Pet profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path, notice: "Pet deleted successfully."
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :other_species, :age, :birthdate)
  end
end
