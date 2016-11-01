class Api::V1::LinksController <  Api::V1::BaseController
include Authenticable
before_action :authenticate_with_token!, only: [:create,:update,:destroy,:index]

  respond_to :json

  def show
 # user = current_user
 #@user = User.find(params[:id])
  link = Link.find(params[:id])
#respond_with User.find(params[:id])
 #render json: user
 render json: link, status: 200
#    respond_with User.find(params[:id]) 
  end


def index

 @user = current_user

if @user != nil
    links = @user.links
end





    # links = params[:link_ids].present? ? Link.find(params[:link_ids]) : Link.all
    #link=links.last
    #render json: links, status: 200
     render json: links, status: 200,location: [:api, :v1, link]

   #respond_with links.last
  end


def destroy
    link = current_user.links.find(params[:id])
    link.destroy
    head 204
  end


  def update

    link = current_user.links.find(params[:id])
    if link.update(link_params)
      render json: link, status: 200
    else
      render json: { errors: link.errors }, status: 422
    end
  end


  def create

    link = current_user.links.build(link_params)
    if link.save
      render json: link, status: 201
    else
      render json: { errors: link.errors }, status: 422
    end
  end

  private
   def link_params
      params.require(:link).permit(:url)
    end












end