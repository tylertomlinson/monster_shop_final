class Merchant::DiscountsController < Merchant::BaseController

  def index
    @discounts = current_merchant.discounts
  end

  def show
    @discount = current_discounts
  end

  def new; end

  def create
    discount = current_merchant.discounts.create(discount_params)
    return if !discount.save && generate_flash(discount) && (render :new)
    redirect_to merchant_discounts_path
  end

  def edit
    @discount = current_discounts
  end

  def update
    @discount = current_discounts
    return if !@discount.update(discount_params) && generate_flash(@discount) && (render :edit)
      flash[:success] = 'Discount updated'
      redirect_to merchant_discount_path(@discount)
  end

  def destroy
    current_discounts.destroy

    flash[:notice] = 'Discount Deleted'
    redirect_to merchant_discounts_path
  end

  private

  def discount_params
    params.permit(:name,
                  :percent_off,
                  :min_quantity)
  end
end
