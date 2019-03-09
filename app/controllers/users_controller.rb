class UsersController < ApplicationController

  def index
  end

  def register_user_tel
    session[:user_info] = params[:user]
  end

  def register_user_address
    @vendor = Vendor.new

  end

  def register_user_card
    vendor = Vendor.create(vendor_params)
    render :register_user_address unless vendor
  end

  def register_user_complete
    # card = Credit_card.create(user_card_info_params)
    # render :register_user_address unless card
  end

  private
  # def user_info_params
  #   params.permit(:email,:nickname, :family_name, :first_name, :family_name_phonetic, :first_name_phonetic, :birth_year, :birth_month, :birth_day)
  # end

  def vendor_params
    params.require(:vendor).permit(:bank, :bank_account, :branch_code, :account_number, :family_name, :first_name, :post_number, :city,:address, :building_name, :created_at, :updated_at, :prefecture_id ).merge(user_id: current_user.id)
  end
  def user_card_info_params
    params.require(:user).permit()
  end

end
