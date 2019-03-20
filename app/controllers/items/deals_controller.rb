class Items::DealsController < ApplicationController
  include CardsActions
  before_action :authenticate_user!
  before_action :prepare_payjp
  before_action :set_item
  before_action :set_address

  def new
  end

  def create
    charge = Payjp::Charge.create(amount: @item.price, customer: @customer, currency: 'jpy') if @card && @address
    if charge.paid
      Deal.create(status: :paid, user_id: current_user.id, item_id: params[:item_id])
      # @item.update(user_id: current_user.id) itemも更新する仕様なら追加
      flash[:notice] = "商品購入が完了しました"
      redirect_to action: :done
    else
      flash[:alert] = "購入が正しく行われませんでした"
      redirect_to action: :new
    end
  end

  def done
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_address
    @address = current_user.street_address
  end

end
