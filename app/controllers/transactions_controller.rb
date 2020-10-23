class TransactionsController < ApplicationController
  before_action :set_item, only: [:new, :create]

  def new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.valid?
      pay_item(@item)
      @transaction.save
      render status: 200, json: { status: 200, message: '商品の購入手続きが完了しました' }
    else
      render action: :new
    end
  end

  private

  def redirect_to_root
    redirect_to :root unless current_user != @item.user && @item&.order.nil?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def transaction_params
    params.permit(:token, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user: current_user, item: @item)
  end

  def pay_item(item)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: item.sell_price,
      card: transaction_params[:token],
      currency: 'jpy'
    )
  end
end
