require 'rails_helper'

RSpec.describe 'merchant bulk index page' do
  before :each do
    @merchant = create(:merchant)

    @bulk_discount_1 = create(:bulk_discount, merchant: @merchant)
    @bulk_discount_2 = create(:bulk_discount, merchant: @merchant)
    @bulk_discount_3 = create(:bulk_discount, merchant: @merchant)
    @bulk_discount_4 = create(:bulk_discount)

    visit merchant_bulk_discounts_path(@merchant)
  end

  it 'displays all merchant discounts and link to show page' do
    within("#discount-#{@bulk_discount_1.id}") do
      expect(page).to have_content(@bulk_discount_1.percentage_discount)
      expect(page).to have_content(@bulk_discount_1.quantity)
    end

    within("#discount-#{@bulk_discount_2.id}") do
      expect(page).to have_content(@bulk_discount_2.percentage_discount)
      expect(page).to have_content(@bulk_discount_2.quantity)
    end
  end

  it 'displays a details link to each discount show page' do
    within("#discount-#{@bulk_discount_3.id}") do
      click_link 'Details'

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount_3))
    end
  end
end
