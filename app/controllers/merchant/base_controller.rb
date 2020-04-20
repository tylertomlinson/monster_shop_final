class Merchant::BaseController < ApplicationController
  before_action :require_merchant

  def current_discounts
    Discount.find(params[:id])
  end

  def current_merchant
    current_user.merchant
  end
end
