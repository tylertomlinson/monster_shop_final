require 'rails_helper'

RSpec.describe Cart do
  describe 'Instance Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 2 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @cart = Cart.new({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2
        })
    end

    it '.contents' do
      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2
        })
    end

    it '.add_item()' do
      @cart.add_item(@hippo.id.to_s)

      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2,
        @hippo.id.to_s => 1
        })
    end

    it '.count' do
      expect(@cart.count).to eq(3)
    end

    it '.items' do
      expect(@cart.items).to eq([@ogre, @giant])
    end

    it '.grand_total' do
      expect(@cart.grand_total).to eq(120)
    end

    it '.count_of()' do
      expect(@cart.count_of(@ogre.id)).to eq(1)
      expect(@cart.count_of(@giant.id)).to eq(2)
    end

    it '.subtotal_of()' do
      expect(@cart.subtotal_of(@ogre.id)).to eq(20)
      expect(@cart.subtotal_of(@giant.id)).to eq(100)
    end

    it '.limit_reached?()' do
      expect(@cart.limit_reached?(@ogre.id)).to eq(false)
      expect(@cart.limit_reached?(@giant.id)).to eq(true)
    end

    it '.less_item()' do
      @cart.less_item(@giant.id.to_s)

      expect(@cart.count_of(@giant.id)).to eq(1)
    end

    it '.applicable_discounts()' do
      @discount_1 = create(:discount, percent_off: 50, min_quantity: 1, merchant: @megan)
      @discount_2 = create(:discount, percent_off: 25, min_quantity: 4, merchant: @megan)
      @discount_3 = create(:discount, percent_off: 10, min_quantity: 5, merchant: @megan)

      expect(@cart.applicable_discounts(@ogre.id)).to eq(50)
      expect(@cart.applicable_discounts(@ogre.id)).to_not eq(25)
      expect(@cart.applicable_discounts(@ogre.id)).to_not eq(10)
    end

    it '.discounted_subtotal()' do
      @discount_1 = create(:discount, percent_off: 50, min_quantity: 1, merchant: @megan)
      @discount_2 = create(:discount, percent_off: 25, min_quantity: 2, merchant: @megan)
      @discount_3 = create(:discount, percent_off: 10, min_quantity: 3, merchant: @megan)

      @discount_1 = create(:discount, percent_off: 50, min_quantity: 1, merchant: @brian)
      @discount_2 = create(:discount, percent_off: 25, min_quantity: 2, merchant: @brian)
      @discount_3 = create(:discount, percent_off: 10, min_quantity: 3, merchant: @brian)

      expect(@cart.discounted_subtotal(@ogre.id)).to eq(10.0)
      expect(@cart.discounted_subtotal(@giant.id)).to eq(25.0)

      expect(@cart.discounted_subtotal(@ogre.id)).to_not eq(20.00)
      expect(@cart.discounted_subtotal(@giant.id)).to_not eq(50.00)
    end

    it '.grand_total_with_discount' do
      @discount_1 = create(:discount, percent_off: 50, min_quantity: 1, merchant: @megan)
      @discount_2 = create(:discount, percent_off: 25, min_quantity: 2, merchant: @megan)
      @discount_3 = create(:discount, percent_off: 10, min_quantity: 3, merchant: @megan)

      @discount_1 = create(:discount, percent_off: 50, min_quantity: 1, merchant: @brian)
      @discount_2 = create(:discount, percent_off: 25, min_quantity: 2, merchant: @brian)
      @discount_3 = create(:discount, percent_off: 10, min_quantity: 3, merchant: @brian)

      expect(@cart.grand_total_with_discount).to eq(60.0)
    end
  end
end
