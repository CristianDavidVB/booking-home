module UserPropertiesHelper
  def property_types_options
    Property.property_types.keys.map do |property_type|
      [property_type.humanize, property_type]
    end
  end

  def currencies_options
    Property.currencies.keys.map do |currency|
      [currency.humanize, currency]
    end
  end
end
