require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts' do
  describe "I visit a merchant's bulk discount index page" do

    before :each do
      @merchant = create(:merchant)

      @bulk_discount_1 = create(:bulk_discount)
      @bulk_discount_2 = create(:bulk_discount)
      @bulk_discount_3 = create(:bulk_discount)

      visit merchant_bulk_discounts_path(@merchant)
    end
end
