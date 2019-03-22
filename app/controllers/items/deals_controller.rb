class Items::DealsController < ApplicationController
  include CardsActions
  before_action :authenticate_user!
  before_action :prepare_payjp
  before_action :set_item_and_image
  before_action :set_vendor

  def new
  end

  def create
    charge = Payjp::Charge.create(amount: @item.price, customer: @customer, currency: 'jpy') if @card && @vendor
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
  def set_item_and_image
    @item = Item.find(params[:item_id])
    @image = @item.item_images[0]
  end

  def set_vendor
    @vendor = current_user.vendor
  end
  def prepare_payjp
    gon.payjp_pk_key =Rails.application.secrets.pay_pk_test
    Payjp.api_key =Rails.application.secrets.pay_sk_test
    unless current_user.payjp_id
      current_user.payjp_id = Payjp::Customer.create(description: 'test').id
      current_user.save
    end
    @customer = Payjp::Customer.retrieve(current_user.payjp_id)
    @card = @customer.cards.retrieve(@customer.default_card) if @customer.cards.count > 0
  end

end
