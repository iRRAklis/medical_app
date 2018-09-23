class CustomFailure < Devise::FailureApp
  def redirect_url
     new_user_session_url(:subdomain => 'secure')
  end

  def respond
    if http_auth?
      http_auth
    else
      if request.referer.include?("admin")
        flash[:error] = "Wrong credentials. Please try again."
        redirect_to admin_root_path
      else
        redirect
      end
    end
  end
end