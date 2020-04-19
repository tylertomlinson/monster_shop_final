class Merchant::DiscountsController < Merchant::BaseController

  def index
    @discounts = current_merchant.discounts
  end

  def show
    @discount = curret_discounts
  end

  def new
    @discount = Discount.new
  end

  def create
    merchant = current_merchant
    discount = merchant.discounts.create(discount_params)

    if discount.save
      redirect_to merchant_discounts_path
    else
      generate_flash(discount)
      render :new
    end
  end

  private

  def discount_params
    params.permit(:name,
                  :percent_off,
                  :min_quantity)
  end
end
