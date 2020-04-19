class Merchant::DiscountsController < Merchant::BaseController

  def index
    @discounts = current_user.merchant.discounts
  end

  def show
    @discount = curret_discounts
  end

  private

  def curret_discounts
    Discount.find(params[:id])
  end

end
