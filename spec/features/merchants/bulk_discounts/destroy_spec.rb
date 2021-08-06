require 'rails_helper'

RSpec.describe 'can delete a bukl discount from merchant index page' do
  before :each do
    @merchant = create(:merchant)

    @bulk_discount_1 = create(:bulk_discount, merchant: @merchant)
    @bulk_discount_2 = create(:bulk_discount, merchant: @merchant)
    @bulk_discount_3 = create(:bulk_discount, merchant: @merchant)
  end

  it 'displays a link to delete bulk discount from merchant' do
    visit merchant_bulk_discounts_path(@merchant)

    within("#discount-#{@bulk_discount_1.id}") do
      expect(page).to have_link('Delete')
    end
  end

  it 'deletes the bulk discount and routes back bulk discount index page' do
    visit merchant_bulk_discounts_path(@merchant)

    within("#discount-#{@bulk_discount_1.id}") do
      click_link 'Delete'
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    expect(page).to_not have_content(@bulk_discount_1.id)
  end
end
