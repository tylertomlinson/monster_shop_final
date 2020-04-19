require 'rails_helper'

RSpec.describe 'Create discount' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_employee = create(:merchant_employee, merchant: @merchant_1)
    @item = create(:item, merchant: @merchant_1)
    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
  end

  describe 'Merchant employee' do
    it 'can create a new discount with correct information' do
      visit '/merchant/discounts'

      click_on 'Add new Discount'

      expect(current_path).to eq('/merchant/discounts/new')

      fill_in 'name', with: @discount_1.name
      fill_in 'percent_off', with: @discount_1.percent_off
      fill_in 'min_quantity', with: @discount_1.min_quantity

      click_on 'Create Discount'

      expect(current_path).to eq('/merchant/discounts')
      expect(page).to have_content(@discount_1.name)
      expect(page).to have_content(@discount_1.percent_off)
      expect(page).to have_content(@discount_1.min_quantity)
    end

    it 'cannot create a new discount with missing information' do
      visit '/merchant/discounts'

      click_on 'Add new Discount'


      fill_in 'percent_off', with: @discount_2.percent_off
      fill_in 'min_quantity', with: @discount_2.min_quantity

      click_on 'Create Discount'

      expect(page).to have_content(": [\"can't be blank\"]")
    end
  end
end
