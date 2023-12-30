class Property < ApplicationRecord
  has_one_attached :photo

  enum property_types: { arriendo: 0, venta: 1 }
  enum currencies: { usd: 0, clp: 1 }

  belongs_to :community
  belongs_to :user

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true, format: { with: /\A.+ \d+\z/, message: 'debe incluir CALLE + NUMERO' }
  validates :photo, presence: true
  validates :description, presence: true
  validates :community_id, presence: true

  validate :validate_photo_format
  validate :description_does_not_contain_contact_info

  def community_name
    community.name if community
  end

  def user_email
    user.email if user
  end

  private

  def validate_photo_format
    return unless photo.attached?

    allowed_formats = %w[image/png image/jpeg image/jpg]

    unless allowed_formats.include?(photo.content_type)
      errors.add(:photo, 'debe ser un archivo PNG, JPG o JPEG')
    end
  end

  def description_does_not_contain_contact_info
    email_regex = /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/
    url_regex = /\b(?:https?|ftp):\/\/\S+\b/
    phone_number_regex = /\b\d{9}\b|\b\d{3}[-.\s]?\d{3}[-.\s]?\d{3}\b/

    if description.match?(email_regex) || description.match?(url_regex) || description.match?(phone_number_regex)
      errors.add(:description, "no puede contener información de contacto")
    end
  end
end
