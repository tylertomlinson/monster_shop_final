class Merchant::DiscountsController < Merchant::BaseController

  def index
    @discounts = current_merchant.discounts
  end

  def show
    @discount = curret_discounts
  end

  def new; end

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

  def edit
    @discount = curret_discounts
  end

  def update
    @discount = curret_discounts

    if @discount.update(discount_params)
      flash[:success] = 'Discount updated'
      redirect_to merchant_discount_path(@discount)
    else
      generate_flash(@discount)
      render :edit
    end
  end

  def destroy
    discount = curret_discounts

    discount.destroy

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
