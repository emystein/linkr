class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])
    @bookmarks = @user.bookmarks.public_bookmarks.paginate(:page => params[:page])
  end

  def create  
    @user = User.new(user_params)
    if @user.save  
      redirect_to login_path, :flash => {:success => "Signed up successfully!"}
    else  
      render "new"  
    end  
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :salt, :encrypted_password)
  end
end
