# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  # before_action :set_user, except: [:index, :show]

  def index
    if current_user.admin?
      @users = User.all
      json_response(@users)
    else
      json_response({ message: Message.invalid_credentials })
    end
  end

  def show
    @user = if current_user.admin?
              User.find(params[:target_id])
            else
              User.find(params[:id])
            end
    json_response(@user)
  end

  def update
    @user = if current_user.admin?
              User.find(params[:target_id])
            else
              User.find(params[:id])
            end
    @user.update(user_params)
    json_response(@user)
  end

  def destroy
    @user = if current_user.admin?
              User.find(params[:target_id])
            else
              User.find(params[:id])
            end
    @user.destroy
    json_response(@user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :f_name, :l_name, :password, :password_confirmation, :role, :target_id)
    end
end
