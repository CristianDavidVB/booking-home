class FetchCurrencyApiService
  BASE_URL = 'https://mindicador.cl/api/dolar'.freeze

  def call
    fetch_currency_api || 0
  rescue Faraday::ConnectionFailed => e
    Rails.logger.info "Error connecting to API: #{e.message}"
    []
  end

  private

  def fetch_currency_api
    usd_value = parse_response(api_request("#{BASE_URL}/#{current_date}"))

    usd_value.blank? ? parse_response(api_request("#{BASE_URL}/#{previous_date}")) : usd_value
  end

  def api_request(url)
    Faraday.get(url)
  end

  def current_date
    Time.current.strftime('%d-%m-%Y')
  end

  def previous_date
    (Time.current - 1.day).strftime('%d-%m-%Y')
  end

  def parse_response(response)
    JSON.parse(response.body)['serie']&.first&.[]('valor')
  end
end
