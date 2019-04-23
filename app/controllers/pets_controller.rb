class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = current_user.pets
  end

  def new
    @pet = current_user.pets.new
  end

  def create
    @pet = current_user.pets.new(pet_params)
    if @pet.save
      redirect_to pets_path, success: "#{@pet.name} has been created"
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @pet.update(pet_params)
      redirect_to pets_path, success: "#{@pet.name} has been updated"
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path, success: "Goodbye #{@pet.name}!"
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :gender, :birthday, :species_id, :avatar_file)
  end

  def set_pet
    @pet = current_user.pets.find(params[:id])
  end
end
