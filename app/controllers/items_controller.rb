class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    binding.pry
    params.require(:item).permit(:name, :imformation_text, :category_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :sell_price).merge(user_id: current_user.id)
  end
end
