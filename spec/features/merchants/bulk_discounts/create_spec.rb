require 'rails_helper'

RSpec.describe 'bulk discount new page' do
  before :each do
    @merchant = create(:merchant)
  end

  it 'can links to new bulk discount pgae from index page' do
    visit merchant_bulk_discounts_path(@merchant)

    click_link 'New Bulk Discount'

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
  end

  it 'can create a new bulk discount' do
    visit new_merchant_bulk_discount_path(@merchant)

    fill_in 'Percentage Discount', with: 20
    fill_in 'Quantity Threshold', with: 15
    click_button 'Create New Bulk Discount'

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    expect(page).to have_content('Percentage Discount: 20 Quantity Threshold: 15')
  end
end
