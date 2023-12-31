class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show ]

  def index
    @pagy, @properties = pagy(find_properties_service, items: 3)
  end

  def show
    @currency = fetch_currency_api_service
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def find_properties_service
    FindPropertiesService.new(get_properties).call(params).with_attached_photo
  end

  def get_properties
    Property.includes(:community, :user)
  end

  def fetch_currency_api_service
    FetchCurrencyApiService.new.call
  end
end
