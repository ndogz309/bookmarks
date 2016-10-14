class Api::V1::UsersController < ApplicationController
include Authenticable
 before_action :authenticate_with_token!, only: [:update, :destroy]
  respond_to :json
  
 

  def show
 # user = current_user
 #@user = User.find(params[:id])
  user = User.find(params[:id])
#respond_with User.find(params[:id])
 #render json: user
 render json: user, status: 200, location: [:api, :v1, user]
#    respond_with User.find(params[:id]) 
  end


 def create
  #respond_with :api, :v1, Device.create(params[:device])
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, :v1, user]

    else
      render json: { errors: user.errors }, status: 422
    end
  end



 # def update
 #    #user = current_user
 #      user = User.find(params[:id])

 #    if user.update(user_params)
 #      render json: user, status: 200, location: [:api,:v1. user]
 #    else
 #      render json: { errors: user.errors }, status: 422
 #    end
 #  end


def update
 # user = User.find(params[:id])
 user = current_user

   #user = User.find_by(auth_token: request.headers['Authorization'])
  if user.update(user_params)
    render json: user, status: 200, location: [:api,:v1, user]
  else
    render json: { errors: user.errors }, status: 422

    
    #render errors: devise_error_messages!, status: 422
   # devise_error_messages!
   #status 422
  end
end



  def destroy
    current_user.destroy
    head 204
  end


  # def create
  #   user = User.new(user_params)
  #   if user.save
  #     render json: user, status: 201, location: [:api, user]
  #   else
  #     render json: { errors: user.errors }, status: 422
  #   end
  # end

  # def create
  #   user = User.new(user_params)
  # #  user = User.find_by(email: params[:email])
  #   if user 
  #    # self.current_user = user
  #    respond_with user
  #   else
  #    # return api_error(status: 401)
  #   end
  # end


#   def create
#     user = User.new(user_params)
#      if user.save
#       #  render json: {
#  #   error: "testing"
# #  }
#      #
#       respond_with user
#      #  render json: user, status: 201 #, location: [:api, user]
#      else
#           render json: {
#     error: "testing fail"
#   }
#       # render json: { errors: user.errors }, status: 422
#      end
#   end
  # def create
  #   user = User.new(user_params)
  #   if user.save
  #     render(
  #       json: Jbuilder.encode do |j|
  #       #  j.success true
  #         j.email user.email
  #         #j.auth_token user.authentication_token
  #       end,
  #       status: 201
  #     )
  #     return
  #   else
  #     warden.custom_failure!
  #     render json: user.errors, status: 422
  #   end
  # end





 
# def index
#     users = User.all

#     render(
#       json: ActiveModel::ArraySerializer.new(
#         users,
#         each_serializer: Api::V1::UserSerializer,
#         root: 'users',
#       )
#     )
#   end


  private

    def user_params
      params.require(:user).permit(:email, :password, :name) 
    end
  
end
