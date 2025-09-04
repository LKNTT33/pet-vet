class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user

    if @pet.save
      redirect_to @pet
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
