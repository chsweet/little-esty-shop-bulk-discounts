class Invoice < ApplicationRecord
  validates :status, presence: true
  belongs_to :customer
  has_many :invoice_items, :dependent => :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, :dependent => :destroy
  enum status: [ 'in progress', :completed, :cancelled ]

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(status: 2)
    .where.not("invoice_items.status = ?", 2)
    .order(created_at: :asc)
    .distinct
  end

  def self.merchants_invoices(merch_id)
    joins(:items).where('merchant_id = ?', merch_id).select("invoices.*").distinct
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity") / 100.00
  end

  def total_discounted_revenue
    invoice_items.sum(&:discounted_inv_item_rev)
  end

  def created_at_display
    created_at.strftime("%A, %B %-d, %Y")
  end

  def price_display
    unit_price / 100.00
  end
end
