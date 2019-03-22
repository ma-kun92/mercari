class Users::Registrations::CardsController < ApplicationController
  include CardsActions
  before_action :prepare_payjp, only: [:new, :create]

  def create
    token = params[:token]
    @customer.cards.create(card: token) if @customer.cards.count == 0
    redirect_to users_registrations_done_path
  end

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
