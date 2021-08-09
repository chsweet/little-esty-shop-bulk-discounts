require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    before :each do
      @merchant = create(:merchant)

      @discount_1 = create(:bulk_discount, percentage_discount: 20, quantity: 10, merchant: @merchant)
      @discount_2 = create(:bulk_discount, percentage_discount: 15, quantity: 15, merchant: @merchant)
      @discount_3 = create(:bulk_discount, percentage_discount: 25, quantity: 25, merchant: @merchant)

      @invoice = create(:invoice)

      @item1 = create(:item, merchant_id: @merchant.id)
      @item2 = create(:item, merchant_id: @merchant.id)

      @invoice_item_1 = InvoiceItem.create!(
        invoice: @invoice,
        item: @item1,
        quantity: 20,
        unit_price: 1000,
        status: 0
      )
      @invoice_item_2 = InvoiceItem.create!(
        invoice: @invoice,
        item: @item2,
        quantity: 15,
        unit_price: 1000,
        status: 0
      )
    end

    describe '#find_discount' do
      it 'returns discount to be applied to invoice item' do
        expect(@invoice_item_1.find_discount).to eq(@discount_1)
        expect(@invoice_item_2.find_discount).to eq(@discount_1)
      end
    end

    describe '#discounted_unit_price' do
      it 'updates invoice item unit price based off the discount' do
        expect(@invoice_item_1.discounted_unit_price).to eq(800)
      end
    end
    describe '#price_display' do
      it 'displays unit_price in dollar amount' do
        invoice = create(:invoice)
        item = create(:item)
        invoice_item = InvoiceItem.create!(
          invoice: invoice,
          item: item,
          quantity: 1,
          unit_price: 11111,
          status: 0
        )
        expect(invoice_item.price_display).to eq(111.11)
      end
    end
  end
end
