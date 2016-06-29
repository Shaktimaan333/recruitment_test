class SessionsController < ApplicationController
  before_action :stay, only: [:new, :create, :destroy]
  def new
  end
  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new'
  	end
  end
  def destroy
    if user_giving_test && current_user.count>0
      log_out if logged_in?
    else
      log_out if logged_in?
      redirect_to root_url
    end
  end
  private
  def stay
    if current_user!=nil
      if current_user.under_test==1
        if current_user.exam_id>0
          if current_user.count>0
            redirect_to que_path(current_user.count)
          else
            redirect_to ques_path
          end
        else
          redirect_to gettest_path
        end
      end
    end
  end
end
