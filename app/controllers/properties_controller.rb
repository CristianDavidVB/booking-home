class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show ]

  def index
    @pagy, @properties = pagy(FindProperties.new(get_properties).call(params), items: 20)
  end

  def show
  end

  private

  def get_properties
    Property.includes(:community, :user)
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
