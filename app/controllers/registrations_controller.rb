class RegistrationsController < Devise::RegistrationsController

respond_to :json #for api

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
  
 def create
    build_resource(sign_up_params)
    resource_saved = resource.save
    yield resource if block_given?

   if resource_saved
 
  
     if resource.active_for_authentication?
        set_flash_message :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)

        
        else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" 
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
 
  
  
  def index
    if params[:search]        
      @users = User.search(params[:search])
    else
      @users = User.all
   end
  end

  protected

    def after_update_path_for(resource)
      user_path(resource)
    end
end