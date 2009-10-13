class UsersController < ApplicationController

  before_filter :load_user, :only => [:edit, :update, :destroy]
  
  def index
    @users = User.displayable
  end

  def new
    @user = flash[:user]
    redirect_to login_path if !@user
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'User was successfully created.'
      redirect_to(users_path)
    else
      render :action => "new"
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to(users_path)
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy

    redirect_to(users_url)
  end
  
  private
  
  def load_user
    @user = current_user
  end
  
end
