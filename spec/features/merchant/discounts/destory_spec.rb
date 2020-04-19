require 'rails_helper'

RSpec.describe 'Delete discount ' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_employee = create(:merchant_employee, merchant: @merchant_1)
    @item = create(:item, merchant: @merchant_1)
    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
  end

  describe 'Merhcant employee' do
    it 'can delete discount and index view is updated' do
      visit "/merchant/discounts/#{@discount_1.id}"

      click_on 'Delete Discount'

      expect(current_path).to eq(merchant_discounts_path)
      expect(page).to have_content('Discount Deleted')
      expect(page).to_not have_content(@discount_1.name)

      expect(page).to have_content(@discount_2.name)
      expect(page).to have_content(@discount_2.percent_off)
      expect(page).to have_content(@discount_2.min_quantity)
    end
  end
end
