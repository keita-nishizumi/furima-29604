class ItemsController < ApplicationController
  def index
    @items = Item.all.order(created_at: 'DESC')
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

  def show
    @item = Item.includes(:user).find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :information_text, :category_id, :status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :sell_price, :image).merge(user_id: current_user.id)
  end
end
