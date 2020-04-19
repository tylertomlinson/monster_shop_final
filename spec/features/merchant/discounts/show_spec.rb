require 'rails_helper'

RSpec.describe "Merchant discount index" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_employee = create(:merchant_employee, merchant: @merchant_1)
    @item = create(:item, merchant: @merchant_1)
    @discount_1 = create(:discount, merchant: @merchant_1)
    @discount_2 = create(:discount, merchant: @merchant_1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
  end

  it "can see each discount with specific info" do

    visit "merchant/discounts/#{@discount_1.id}"
    
    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content(@discount_1.percent_off)
    expect(page).to have_content(@discount_1.min_quantity)

    visit "merchant/discounts/#{@discount_2.id}"

    expect(page).to have_content(@discount_2.name)
    expect(page).to have_content(@discount_2.percent_off)
    expect(page).to have_content(@discount_2.min_quantity)
 end
end
