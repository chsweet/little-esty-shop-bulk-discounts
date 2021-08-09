require 'rails_helper'

RSpec.describe 'Merchant Invoices show page' do
  before :each do
    @merchant = create(:merchant)

    @discount_1 = create(:bulk_discount, percentage_discount: 10, quantity: 20, merchant: @merchant)
    @discount_2 = create(:bulk_discount, percentage_discount: 15, quantity: 15, merchant: @merchant)

    @customer = create(:customer)

    @invoice = create(:invoice, customer_id: @customer.id)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice.id, quantity: 15, status: 1)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice.id, quantity: 20, status: 1)
    @invoice_item_3 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice.id, quantity: 5, status: 1)

    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  it 'can see all of that merchants invoice info' do
    expect(page).to have_content("Invoice ##{@invoice.id}")
    expect(page).to have_content("Status: #{@invoice.status}")
    expect(page).to have_content("Created On: #{@invoice.created_at.strftime('%A, %B %d, %Y')}")
    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  it "displays the invoice item information such as the item name, quantity ordered, price of item, invoice item status" do
    within "#invoice_item-info-#{@invoice_item_1.id}" do
      expect(page).to have_content("Invoice item name: #{@item_1.name}")
      expect(page).to have_content("Invoice item quantity: #{@invoice_item_1.quantity}")
      expect(page).to have_content("Invoice item price: #{@invoice_item_1.price_display}")
      expect(page).to have_content("Invoice item status: #{@invoice_item_1.status}")
    end

    within "#invoice_item-info-#{@invoice_item_2.id}" do
      expect(page).to have_content("Invoice item name: #{@item_2.name}")
      expect(page).to have_content("Invoice item quantity: #{@invoice_item_2.quantity}")
      expect(page).to have_content("Invoice item price: #{@invoice_item_2.price_display}")
      expect(page).to have_content("Invoice item status: #{@invoice_item_2.status}")
    end
  end

  it "displays the total revenue from all items on the invoice" do
    expect(page).to have_content("Total revenue from invoice: #{@invoice.total_revenue}")
  end

  it 'can click on the select status for an item and update it to a new status' do
    within "#invoice_item-info-#{@invoice_item_1.id}" do

     expect(page).to have_content("Invoice item status: #{@invoice_item_1.status}")

     expect(page).to have_select(:status, selected: 'packaged')
     expect(page).to have_select(:status, :options => ['pending', 'packaged', 'shipped'])

     select('shipped', from: 'status')

     click_on('Update Item Status')

     expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")

     expect(page).to have_select(:status, selected: 'shipped')
   end
  end

  it 'displays the total revenue from all items on the invoice' do
    expect(page).to have_content("Total discounted revenue from invoice: #{@invoice.total_discounted_revenue}")
  end

  xit 'displays a link to the discount show page next to each item it applied to' do
    within "#invoice_item-info-#{@invoice_item_1.id}" do
      expect(page).to have_link("Discount")
    end

    within "#invoice_item-info-#{@invoice_item_2.id}" do
      expect(page).to have_link("Discount")
    end

    within "#invoice_item-info-#{@invoice_item_3.id}" do
      expect(page).to_not have_link("Discount")
    end
  end
end
