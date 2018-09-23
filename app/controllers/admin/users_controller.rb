class Admin::UsersController < Admin::BaseController
	before_action :set_user, only: [:show, :update]

	def index
		@users = User.paginate(page: params[:page], per_page: 8)
	end

	def show
	end

	def update
		if @user.update(user_params)
			redirect_to admin_user_path(@user)
		else
			render 'edit'
		end
	end

	private
    def user_params
      params.require(:user).permit(:email)
    end

    def set_user
    	@user = User.find(params[:id])
    end
end