require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe "I visit a merchant dashboard" do

    before :each do
      @merchant = create(:merchant)

      @bulk_discount_1 = create(:bulk_discount)
      @bulk_discount_2 = create(:bulk_discount)
      @bulk_discount_3 = create(:bulk_discount)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)
      @customer_7 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1, created_at: '2021-07-10 00:00:00 UTC')
      @invoice_2 = create(:invoice, customer: @customer_2, created_at: '2021-07-07 00:00:00 UTC')
      @invoice_3 = create(:invoice, customer: @customer_3, created_at: '2021-07-12 00:00:00 UTC')
      @invoice_4 = create(:invoice, customer: @customer_4, created_at: '2021-07-09 00:00:00 UTC')
      @invoice_5 = create(:invoice, customer: @customer_5, created_at: '2021-07-06 00:00:00 UTC')
      @invoice_6 = create(:invoice, customer: @customer_6, created_at: '2021-07-11 00:00:00 UTC')
      @invoice_7 = create(:invoice, customer: @customer_7, created_at: '2021-07-08 00:00:00 UTC')

      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_1)
      @transaction_4 = create(:transaction, invoice: @invoice_2)
      @transaction_4 = create(:transaction, invoice: @invoice_2)
      @transaction_5 = create(:transaction, invoice: @invoice_2)
      @transaction_6 = create(:transaction, invoice: @invoice_2)
      @transaction_8 = create(:transaction, invoice: @invoice_3)
      @transaction_8 = create(:transaction, invoice: @invoice_3)
      @transaction_9 = create(:transaction, invoice: @invoice_3)
      @transaction_10 = create(:transaction, invoice: @invoice_3)
      @transaction_11 = create(:transaction, invoice: @invoice_3)
      @transaction_12 = create(:transaction, invoice: @invoice_4)
      @transaction_13 = create(:transaction, invoice: @invoice_5)
      @transaction_14 = create(:transaction, invoice: @invoice_6)
      @transaction_15 = create(:transaction, invoice: @invoice_6)
      @transaction_16 = create(:transaction, invoice: @invoice_6)
      @transaction_17 = create(:transaction, invoice: @invoice_7)
      @transaction_18 = create(:transaction, invoice: @invoice_7)
      @transaction_19 = create(:transaction, invoice: @invoice_7)
      @transaction_20 = create(:transaction, invoice: @invoice_7)
      @transaction_21 = create(:transaction, invoice: @invoice_7)
      @transaction_22 = create(:transaction, invoice: @invoice_7)

      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @item_3 = create(:item, merchant: @merchant)
      @item_4 = create(:item, merchant: @merchant)


      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status: :packaged)
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_1, status: :shipped)
      @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_2, status: :pending)
      @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_2, status: :shipped)
      @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_3, status: :packaged)
      @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_4, status: :packaged)
      @invoice_item_7 = create(:invoice_item, invoice: @invoice_7, item: @item_4, status: :packaged)

      visit merchant_dashboard_index_path(@merchant)
    end

    it "displays the merchant name" do
      expect(page).to have_content(@merchant.name)
    end

    it 'displays a link to my items index page and my invoices index page' do
      expect(page).to have_link("My Items")
      click_link("My Items")
      expect(page).to have_current_path("/merchants/#{@merchant.id}/items")

      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_link("My Invoices")
      click_link("My Invoices")
      expect(page).to have_current_path("/merchants/#{@merchant.id}/invoices")
    end

    it 'displays the names of the top 5 customers by successfull transactions' do
      expect(page).to have_content(@customer_7.first_name)
      expect(page).to have_content(@customer_7.last_name)
      expect(page).to have_content("6 purchases")

      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content("5 purchases")

      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content("4 purchases")

      expect(page).to have_content(@customer_6.first_name)
      expect(page).to have_content(@customer_6.last_name)
      expect(page).to have_content("3 purchases")

      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content("2 purchases")

      expect(page).to_not have_content(@customer_4.first_name)
      expect(page).to_not have_content(@customer_4.last_name)
      expect(page).to_not have_content(@customer_5.first_name)
      expect(page).to_not have_content(@customer_5.last_name)

      expect(@customer_7.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_2.first_name)
      expect(@customer_2.first_name).to appear_before(@customer_6.first_name)
      expect(@customer_6.first_name).to appear_before(@customer_1.first_name)
    end
    #user story 1 - bulk discounts
    it 'displays link to the merchants bulk discounts index page' do
      expect(page).to have_link('Bulk Discounts')

      click_link 'Bulk Discounts'

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    end
    describe 'Items Ready to Ship' do
      it 'displays all items that are ready to ship and link to the invoice' do
        within('.ready-ship') do
          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@invoice_1.id)

          expect(page).to have_content(@item_2.name)
          expect(page).to have_content(@invoice_3.id)

          expect(page).to have_content(@item_3.name)
          expect(page).to have_content(@invoice_5.id)

          expect(page).to have_content(@item_4.name)
          expect(page).to have_content(@invoice_6.id)

          expect(page).to have_content(@item_4.name)
          expect(page).to have_content(@invoice_7.id)

          expect(page).to_not have_content(@invoice_2.id)
          expect(page).to_not have_content(@invoice_4.id)

          click_link("#{@invoice_7.id}")
          expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_7))
        end
      end

      it 'displays invoice date next to item and is sorted by date' do
        within('.ready-ship') do
          expect(page).to have_content('Saturday, July 10, 2021')
          expect(page).to have_content('Monday, July 12, 2021')
          expect(page).to have_content('Tuesday, July 6, 2021')
          expect(page).to have_content('Sunday, July 11, 2021')
          expect(page).to have_content('Thursday, July 8, 2021')

          expect('Tuesday, July 6, 2021').to appear_before('Thursday, July 8, 2021')
          expect('Thursday, July 8, 2021').to appear_before('Saturday, July 10, 2021')
          expect('Saturday, July 10, 2021').to appear_before('Sunday, July 11, 2021')
          expect('Sunday, July 11, 2021').to appear_before('Monday, July 12, 2021')
        end
      end
    end
  end
end
