class UsersController < ApplicationController
  before_action :set_user
  before_action :authorize_user

  def show
  end

  def edit
    @diseases = Disease.all
  end

  def update
  	if @user.update(user_params)
      @user.remove_image! if params[:remove_image] == "1"
      @user.diseases = diseases
  	  redirect_to @user
  	 else
      flash.now[:error] = @user.errors.full_messages
      render 'edit'
  	end
  end

  private
    def user_params
      params.require(:user).permit(:full_name, :amka, :father_amka, :mother_amka, :disease_ids, :image, :remove_image)
    end

    def diseases
      Disease.where(id: params[:disease_ids])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def authorize_user
      if current_user.blank?
        flash[:error] = "You must sign in first."
        redirect_to root_path
      elsif current_user.present? && current_user != @user
        raise ActionController::RoutingError.new('Not Found')
      end
    end
end