class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_root, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:order).order(created_at: 'DESC')
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to :root
  end

  private

  def item_params
    params.require(:item).permit(:name, :information_text, :category_id, :status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :sell_price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.includes([:user, :image_attachment, :order]).find(params[:id])
  end

  def redirect_to_root
    redirect_to :root unless @item.user == current_user
  end
end
