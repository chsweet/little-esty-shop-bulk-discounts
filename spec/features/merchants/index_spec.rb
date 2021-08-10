require 'rails_helper'

RSpec.describe 'Merchant Index Page' do
  before :each do
    @merchant_1, @merchant_2, @merchant_3 = create_list(:merchant, 3)
    visit merchants_path
  end

  it 'Lists all Merchants and a link to their page' do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)

    click_link "#{@merchant_1.name}"
    expect(current_path).to eq(merchant_dashboard_index_path(@merchant_1))

    visit merchants_path
    click_link "#{@merchant_2.name}"
    expect(current_path).to eq(merchant_dashboard_index_path(@merchant_2))

    visit merchants_path
    click_link "#{@merchant_3.name}"
    expect(current_path).to eq(merchant_dashboard_index_path(@merchant_3))
  end
end
