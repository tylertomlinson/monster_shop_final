require 'rails_helper'

RSpec.describe "Merchant discount index" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_employee = create(:merchant_employee, merchant: @merchant_1)
    @item = create(:item, merchant: @merchant_1)
    @discount = create(:discount, merchant: @merchant_1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)
  end

  it "nav bar has discount link to index page" do
    visit root_path
      within 'nav' do
        click_link 'My Discounts'
      end
    expect(current_path).to eq("/merchant/discounts")
  end
end
