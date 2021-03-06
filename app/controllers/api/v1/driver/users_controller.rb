# frozen_string_literal: true

class Api::V1::Driver::UsersController < ApplicationController
  before_action :set_user, except: [:index]

  def index
    @users = policy_scope([:api, :v1, User])
    authorize [:api, :v1, @users]
    serialized_response(@users)
  end

  def show
    authorize [:api, :v1, @user]
    serialized_response(@user)
  end

  def update
    authorize [:api, :v1, @user]
    @user.update(user_params)
    serialized_response(@user)
  end

  def destroy
    authorize [:api, :v1, @user]
    @user.destroy!
    serialized_response(@user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(policy([:api, :v1, User]).permitted_attributes)
    end
end
