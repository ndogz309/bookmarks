class Api::V1::SessionsController < ApplicationController
# sign in handled by a POST request to the create action
# sign out handled by a DELETE request to the destroy action
# including sign out so can update the authentication token so old one expires


def create


  user_password = params[:session][:password]
  user_email = params[:session][:email]
  #user_email = "test@test.com"
   # user_password = "password"
  #  user_email = "test@test.com"
  

    user = user_email.present? && User.find_by(email: user_email)

 #if user and valid_password? user_password
 if user
    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200, location: [:api,:v1, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end

  else

    render json: { errors: "Invalid email or password" }, status: 422
#render json: { errors: "no user" }, status: 422
  end

  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end



end



