class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user

  def update
    begin
      if @user.update(user_params)
        @user.remove_image! if params[:remove_image] == "1"
        render json: Api::V1::UserSerializer.new(@user), status: :ok
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: validation_errors(e) }, status: :ok
    end
  end

  def update_password
    if @user && @user.valid_password?(params[:user][:current_password])
      if params[:user][:password] == params[:user][:password_confirmation]
        if @user.update(user_params)
          render json: @user.as_json(only: [:email, :password]), status: :ok
        end
      else
        render json: { error: "Password & Password confirmation are not identical" }, status: :ok
      end
    else
      render json: { error: "Wrong current password" }, status: :ok
    end
  end

  def update_history
    begin
      @user.diseases << diseases
      render json: Api::V1::UserSerializer.new(@user), status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: validation_errors(e) }, status: :ok
    end
  end

  def set_image
    begin
      base64_data      = params[:image_data]
      api_image_helper = ApiImageHelper.new(base64_data, @user)

      api_image_helper.set_class_variable!

      image            = CarrierwaveStringIO.new(Base64.decode64(api_image_helper.image_data))

      @user.image      = image
      @user.save

      api_image_helper.reset_class_variable!

      render json: Api::V1::UserSerializer.new(@user), status: :ok
    rescue Exception => e
      render json: { error: e.message }
    end
  end

  private
    def user_params
      params.require(:user).permit(:email,:password,:password_confirmation, :full_name, :amka, :father_amka, :mother_amka, :image, :remove_image)
    end

    def set_user
      @user ||= User.find_by(email: params[:user][:email])
    end

    def diseases
      Disease.where(id: [params[:user][:diseases]])
    end

    def validation_errors(e)
      e.message.split(": ").second
    end

end