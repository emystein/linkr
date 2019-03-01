class SessionsController < ApplicationController
  def new
    redirect_to :dashboard if current_user
  end

  def create  
    user = User.by_login(params[:login]).first 

    if user && user.authenticate(params[:password])  
      session[:user_id] = user.id  
      redirect_to :dashboard, :flash => {:success => "Logged in successfully."}
    else  
      flash[:error] = "Invalid login or password"  
      render "new"  
    end  
  end  

  def destroy
    session[:user_id] = nil  
    redirect_to login_path, :flash => {:success => "Logged out sucessfully."}
  end
end
