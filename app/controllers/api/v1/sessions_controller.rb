class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.valid_password?(params[:password])
      @user.ensure_authentication_token
      @user.save

      user_details = Api::V1::UserSerializer.new(@user)
      articles     = ActiveModel::Serializer::CollectionSerializer.new(Article.all.to_a, serializer: Api::V1::ArticleSerializer)
      
      render json: { user: user_details, articles: articles }, status: :created
    else
      head(:unauthorized)
    end
  end

  def destroy
    @user = User.where(email: params[:session][:email], authentication_token: params[:session][:authentication_token]).first
    if @user
      @user.update_column(:authentication_token, nil)
      render json: { message: "Successfully signed out" }, status: :deleted
    end
  end
end
