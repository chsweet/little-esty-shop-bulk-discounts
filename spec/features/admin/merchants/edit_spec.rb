require 'rails_helper'

RSpec.describe 'admin merchant edit page' do
  before :each do
    @merchant_1 = create(:merchant)
  end

  it 'admin merchant show page has link to edit page' do
    visit admin_merchant_path(@merchant_1)

    click_link 'Update Merchant'

    expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
  end

  it 'displays form with existing merchant attributes' do
    visit edit_admin_merchant_path(@merchant_1)

    find_field('Name', with: "#{@merchant_1.name}").value
  end

  it 'updates merchant info from form' do
    visit edit_admin_merchant_path(@merchant_1)

    fill_in 'Name', with: 'Chuck Norris'
    click_button('Submit')

    expect(current_path).to eq(admin_merchant_path(@merchant_1))
    expect(page).to have_content('Chuck Norris')
  end

  it 'displays flash message on show page when updated' do
    visit edit_admin_merchant_path(@merchant_1)

    fill_in 'Name', with: 'Chuck Norris'
    click_button('Submit')

    expect(current_path).to eq(admin_merchant_path(@merchant_1))
    # should the flash notice be in a section block?
    expect(page).to have_content('Merchant Sucessfully Updated')
  end
end
