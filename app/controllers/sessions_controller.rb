class SessionsController < ApplicationController

  def create
    open_id_authentication params[:openid_url]
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def open_id_authentication(identity_url)
    identity_url.strip!
    authenticate_with_open_id(identity_url,
                              :optional => [:fullname, :email]) do |result, identity_url, registration|
      if result.successful?
        if @current_user = User.find_by_identity_url(identity_url)
          successful_login
        else
          forward_new_user identity_url, registration
        end
      else
        flash.now[:notice] = result.message
        render :new
      end
    end
  end

  def successful_login
    flash[:notice] = "Signed in as #{@current_user.name}"
    session[:user_id] = @current_user.id
    redirect_to(root_url)
  end

  def forward_new_user(identity_url, registration)
    new_user = User.new(:identity_url => identity_url,
                        :email => registration['email'],
                        :name => registration['fullname'])
    flash[:user] = new_user
    redirect_to new_user_path
  end

end
