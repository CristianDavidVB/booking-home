class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show ]

  def index
    @pagy, @properties = pagy(FindProperties.new(get_properties).call(params), items: 3)
  end

  def show
    @currency = fetch_currency_api_service
  end

  private

  def get_properties
    Property.includes(:community, :user)
  end

  def set_property
    @property = Property.find(params[:id])
  end

  def fetch_currency_api_service
    FetchCurrencyApiService.new.call
  end
end
