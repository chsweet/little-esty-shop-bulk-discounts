class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  belongs_to :invoice
  belongs_to :item
  enum status: [ :pending, :packaged, :shipped ]

  def find_discount
    item.merchant.bulk_discounts.where('bulk_discounts.quantity <= ?', quantity).order(percentage_discount: :desc).first
  end

  def discounted_unit_price
    if find_discount.nil?
      unit_price
    else
      unit_price - (unit_price * (find_discount.percentage_discount / 100.0))
    end
  end

  def discounted_inv_item_revenue
    discounted_unit_price * quantity / 100.0
  end

  def price_display
    unit_price / 100.00
  end
end
