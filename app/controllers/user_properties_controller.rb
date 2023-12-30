class UserPropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_property, only: %i[ show edit update destroy ]

  def index
    @pagy, @user_properties = pagy(find_properties_service, items: 3)
  end

  def show
    @currency = fetch_currency_api_service
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

  def find_properties_service
    FindPropertiesService.new(get_user_properties).call(params).with_attached_photo
  end

  def fetch_currency_api_service
    FetchCurrencyApiService.new.call
  end
end
