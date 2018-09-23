class RegistrationsController < Devise::RegistrationsController
  
  # overriden for setting flash messages
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      flash.now[:error] = resource.errors.full_messages
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # overriden for setting flash messages
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      flash.now[:error] = resource.errors.full_messages
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :amka, :father_amka, :mother_amka, :gender)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :full_name, :amka, :father_amka, :mother_amka, :gender)
    end

    def after_sign_up_path_for(resource)
      user_path(resource)
    end

    def after_update_path_for(resource)
      user_path(resource)
    end
end
