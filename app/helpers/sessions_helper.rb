module SessionsHelper
  
  def sign_in(user)
    cookies[:auth_token] = user.auth_token
  end
  
  def current_user
    if cookies[:auth_token]
      if User.find_by_auth_token(cookies[:auth_token])
        user = User.find_by_auth_token(cookies[:auth_token])
      end
      user
    end
  end
end
