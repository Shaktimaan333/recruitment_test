class HeadshotDemoController < ApplicationController
  #before_action :giving_test, only: [:index]
  helper :headshot
  def index
    if current_user!=nil
      @current = current_user.count
    end
  end
  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def giving_test
    if !user_giving_test
      flash[:danger] = "You cannot go directly"
      redirect_to root_path
    end
  end
end
