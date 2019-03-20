class UsersController < ApplicationController
  before_action :header_menu,only: [:index,:edit,:index,:logout]
  before_action :authenticate_user!, only: :index

  def index
  end

  def edit
    @user = current_user
  end

  def update
    if User.update(update_params)
      redirect_to users_path
    else
      renderb:edit
    end
  end

  def logout

  end

  private
  def update_params
    params.require(:user).permit(:nickname, :profile, :icon)
  end
end
