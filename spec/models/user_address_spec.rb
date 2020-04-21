require 'rails_helper'

RSpec.describe UserAddress do
  describe 'Relationships' do
    it {should belong_to :user}
  end

  describe 'Validations' do
    it {should validate_presence_of :nickname}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end
end
