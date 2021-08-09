class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  belongs_to :invoice
  belongs_to :item
  enum status: [ :pending, :packaged, :shipped ]

  #it does not like when i call on the table name .where('bulk_discount.quantity <= ?', 'ivnoice_item.quantity')
  def find_discount
    item.merchant.bulk_discounts.where('quantity <= ?', quantity).maximum('percentage_discount').to_f / 100
  end

  def discounted_unit_price
    unit_price - (unit_price * find_discount)
  end

  def price_display
    unit_price / 100.00
  end
end
