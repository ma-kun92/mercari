class VendorsController < ApplicationController
  def new
    @vendor = Vendor.new
  end

  def create
    vendor = Vendor.new(create_params)
    if vendor.save
      redirect_to users_path
    else
      render action: 'new'
    end
  end

  def edit
    vendor = Vendor.find_by(user_id: current_user.id)
    if vendor
      @vendor = vendor
    else
      @vendor = Vendor.new
    end
  end

  def update
    if Vendor.update(create_params)
      redirect_to users_path
    else
      render action: 'edit'
    end
  end

  private
  def create_params
    params.require(:vendor).permit(:post_number, :prefecture_id, :city, :address, :building_name, :family_name,:first_name, :first_name_phonetic, :family_name_phonetic).merge(user_id: current_user.id)
  end
end
