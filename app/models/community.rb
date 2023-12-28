class Community < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
