class Api::V1::RegistrationsController < Devise::RegistrationsController
  # useful in case of api
  skip_before_action :verify_authenticity_token

  respond_to :json

  # overriden in order to render serialized user
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)

        user_details = Api::V1::UserSerializer.new(resource)
        articles     = ActiveModel::Serializer::CollectionSerializer.new(Article.all.to_a, serializer: Api::V1::ArticleSerializer)

        render json: { user: user_details, articles: articles }, status: :created
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected
    # overriden because resource_name = :api_v1_user due to namespaces in routes.rb
    def resource_name
     :user
    end

  private
    #Override for editing custom user fields (full_name, amka)
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :amka, :father_amka, :mother_amka, :gender)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :full_name, :amka, :father_amka, :mother_amka, :gender)
    end
end