require 'rails_helper'

RSpec.describe 'Edit discount' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_employee = create(:merchant_employee, merchant: @merchant_1)
    @item = create(:item, merchant: @merchant_1)
    @discount_1 = create(:discount, merchant: @merchant_1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)

    visit "/merchant/discounts/#{@discount_1.id}"

    click_on 'Edit Discount'
  end

  describe "Merchant employee" do
    it 'can edit discount information ' do
      visit "/merchant/discounts/#{@discount_1.id}"

      click_on 'Edit Discount'

      expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")

      fill_in 'name', with: 'Test Name'
      fill_in 'percent_off', with: 100
      fill_in 'min_quantity', with: 30

      click_on 'Update Discount'

      discount_2 = Discount.last

      expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}")

      expect(page).to have_content(discount_2.name)
      expect(page).to have_content(discount_2.percent_off)
      expect(page).to have_content(discount_2.min_quantity)
    end

    it 'cant edit discount with invalid information' do

      visit "/merchant/discounts/#{@discount_1.id}"

      click_on 'Edit Discount'

      fill_in :name, with: ''
      fill_in :percent_off, with: ''
      fill_in :min_quantity, with: ''

      click_on 'Update Discount'

      expect(page).to have_content("name: [\"can't be blank\"]")
      expect(page).to have_content("percent_off: [\"can't be blank\", \"is not a number\"]")
      expect(page).to have_content("min_quantity: [\"can't be blank\", \"is not a number\"]")

      expect(page).to have_button('Update Discount')
    end
  end
end
