class Property < ApplicationRecord
  enum property_types: { arriendo: 0, venta: 1 }
  enum currencies: { usd: 0, clp: 1 }

  belongs_to :community

  validates :price, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :community_id, presence: true

  validate :description_does_not_contain_contact_info

  private

  def description_does_not_contain_contact_info
    email_regex = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/
    url_regex = /\b(?:https?|ftp):\/\/\S+\b/
    phone_number_regex = /\b(?:\+?56)?\s?9?\d{8}\b/

    if description.match?(email_regex) || description.match?(url_regex) || description.match?(phone_number_regex)
      errors.add(:description, "no puede contener información de contacto")
    end
  end
end
