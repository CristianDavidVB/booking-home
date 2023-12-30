class UserPropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_property, only: %i[ show edit update destroy ]

  def index
    @pagy, @user_properties = pagy(FindProperties.new(get_user_properties).call(params), items: 20)
  end

  def show
  end

  def new
    @user_property = current_user.properties.new
  end

  def create
    @user_property = current_user.properties.new(property_params)

    if @user_property.save
      redirect_to user_properties_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user_property.update(property_params)
      redirect_to user_properties_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_property.destroy
    redirect_to user_properties_path
  end

  private

  def get_user_properties
    current_user.properties.includes(:community)
  end

  def set_user_property
    @user_property = current_user.properties.find(params[:id])
  end

  def property_params
    params.require(:property).permit(
      :property_types,
      :price,
      :currencies,
      :community_id,
      :address,
      :area,
      :nro_rooms,
      :nro_bathrooms,
      :photo,
      :description,
    )
  end
end
