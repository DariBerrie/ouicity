class SubscribersController < ApplicationController

  def subscribe
    @user = User.find(params[:id])
    @current_user=User.find_by(id: session[:user][‘id’])
    @current_user.followees << @user
    @current_user.save
    redirect_back(fallback_location:”/”)
  end

   def unsubscribe
    @user = User.find(params[:id])
    @current_user=User.find_by(id: session[:user][‘id’])
    @current_user.followees.delete(@user)
    @current_user.save
    redirect_back(fallback_location:”/”)
  end
end
