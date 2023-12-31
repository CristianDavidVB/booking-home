module ApplicationHelper
  include Pagy::Frontend

  def converted_price(property)
    if property.currencies == 'clp'
      price_in_usd = property.price / (@currency > 0 ? @currency : 1)
      return price_in_usd.round(2)
    end

    if property.currencies == 'usd'
      price_in_clp = property.price * @currency
      price_in_clp.round(0)
    end
  end

  def exchange_currency(exchange_currency)
    exchange_currency == 'clp' ? 'USD' : 'CLP'
  end
end
