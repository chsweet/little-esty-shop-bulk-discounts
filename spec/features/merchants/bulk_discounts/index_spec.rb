require 'rails_helper'

RSpec.describe 'merchant bulk discoutnt index page' do
  before :each do
    @merchant = create(:merchant)

    @discount_1 = create(:bulk_discount, merchant: @merchant)
    @discount_2 = create(:bulk_discount, merchant: @merchant)
    @discount_3 = create(:bulk_discount, merchant: @merchant)
    @discount_4 = create(:bulk_discount)

    visit merchant_bulk_discounts_path(@merchant)
  end

  it 'displays all merchant discounts and link to show page' do
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_content(@discount_1.percentage_discount)
      expect(page).to have_content(@discount_1.quantity)
    end

    within("#discount-#{@discount_2.id}") do
      expect(page).to have_content(@discount_2.percentage_discount)
      expect(page).to have_content(@discount_2.quantity)
    end
  end

  it 'displays a details link to each discount show page' do
    within("#discount-#{@discount_3.id}") do
      click_link 'Details'

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_3))
    end
  end

  it 'displays the next 3 upcoming US holidays' do
    within("#holidays") do
      expect(page).to have_content("Labour Day 2021-09-06")
      expect(page).to have_content("Columbus Day 2021-10-11")
      expect(page).to have_content("Veterans Day 2021-11-11")
      expect(page).to_not have_content("Thanksgiving Day 2021-11-25")
    end
  end
end
