require 'rails_helper'

RSpec.describe 'merchant bulk discount show page' do
  before :each do
    @merchant = create(:merchant)

    @discount_3 = create(:bulk_discount, percentage_discount: 15, quantity: 5, merchant: @merchant)
  end

  it 'displays a link to edit discount page' do
    visit merchant_bulk_discount_path(@merchant, @discount_3)

    click_link 'Edit Discount'

    expect(current_path).to eq(edit_merchant_bulk_discount(@merchant, @discount_3))
  end

  it 'diplays form with current attributes' do
    visit edit_merchant_bulk_discount(@merchant, @discount_3)

    expect(page).to have_content("Percentage Discount: #{@discount_3.percentage_discount}")
    expect(page).to have_content("Quantity Threshold: #{@discount_3.quantity}")
  end

  it 'Redirects to show page after form is submitted' do
    visit edit_merchant_bulk_discount(@merchant, @discount_3)

    fill_in 'Percentage Discount', with: 20
    fill_in 'Quantity Threshold', with: 15
    click_button 'Update Bulk Discount'

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_3))
  end
end
