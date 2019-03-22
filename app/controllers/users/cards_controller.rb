class Users::CardsController < ApplicationController
  include CardsActions
  before_action :authenticate_user!, only: [:show, :new, :create, :destroy]
  before_action :prepare_payjp, only: [:show, :new, :create, :destroy]
  before_action :header_menu,only: [:new,:show]
  add_breadcrumb 'メルカリ', :root_path
  add_breadcrumb 'マイページ', :users_path
  add_breadcrumb '支払い方法', :card_path, only: [:show, :new]
  add_breadcrumb 'クレジットカード情報入力', :new_card_path, only: [:new]

  private
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
