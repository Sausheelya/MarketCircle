class Person < ApplicationRecord
  has_one :detail, dependent: :destroy
  validates :name, presence: true
end
