class BulkDiscount < ApplicationRecord
  validates :percentage_discount, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
  belongs_to :merchant
end
