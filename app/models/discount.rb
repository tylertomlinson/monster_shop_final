class Discount < ApplicationRecord
  validates_presence_of :name,
                        :percent_off,
                        :min_quantity

  validates :percent_off, numericality: { greater_than: 0, less_than_or_equal_to: 100, only_integer: true }

  validates :min_quantity, numericality: { greater_than: 0, only_integer: true }

  belongs_to :merchant
end
