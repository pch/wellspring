require_dependency "wellspring/application_controller"

module Wellspring
  class UsersController < ApplicationController
    before_action :set_user

    def show
    end

    def edit
    end

    def update
      if current_user.update(user_params)
        flash[:notice] = 'Your profile was updated'
        redirect_to user_path(@user)
      else
        render :edit
      end
    end

    private

    def set_user
      @user = User.find(arams[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end
  end
end
