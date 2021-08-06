require 'rails_helper'

RSpec.describe 'merchant bulk discount show page' do
  before :each do
    @merchant = create(:merchant)

    @bulk_discount_3 = create(:bulk_discount, merchant: @merchant)

    visit merchant_bulk_discount_path(@merchant, @bulk_discount_3)
  end

  it 'displays the bulk discount quantity threshold and percentage discount' do
    expect(page).to have_content(@bulk_discount_3.quantity)
    expect(page).to have_content(@bulk_discount_3.percentage_discount)
  end
end
