require 'rails_helper'

RSpec.describe 'Admin Invoice show page' do
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
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice.id, quantity: 5, status: 1)

    visit admin_invoice_path(@invoice)
  end

  it 'shows information regarding the invoice' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.created_at_display)
    expect(page).to have_content(@invoice.customer.first_name)
    expect(page).to have_content(@invoice.customer.last_name)
  end

  it 'shows invoice items and item information' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price / 100)
    expect(page).to have_content(@invoice_item_1.status)
  end

  it 'shows total revenue to be earned through invoice' do
    save_and_open_page
    expect(page).to have_content("Total Projected Revenue: #{@invoice.total_revenue}")
  end

  it 'displays select field with current invoice status selected' do
    expect(page).to have_content('Status:')
    expect(page).to have_select(selected: "#{@invoice.status.titleize}")
  end

  xit 'can update status using select field' do
    expect(@invoice.status).to eq('in progress')
    select('Completed')
    click_button 'Update Invoice'
    @invoice.reload
    expect(@invoice.status).to eq('completed')
  end

  it 'displays the total discounted revenue from all items on the invoice' do
    expect(page).to have_content("Total Projected Discounted Revenue: #{@invoice.total_discounted_revenue}")
  end
end
