class StaticPagesController < ApplicationController
  #before_action :cant_go_back, only: [:home, :help, :about, :contact, :faq] 
  def home
    @ipq = request.remote_ip
    @ipw = request.env['REMOTE_ADDR']
    @ipe = request.env["HTTP_X_FORWARDED_FOR"]
    @ipr = request.remote_addr
  end
  def help
  end
  
  def about
  end
  def contact
  end
  def faq
  end
  private
  def cant_go_back
    if logged_in?
      if current_user.under_test==1
        if current_user.count>0
          redirect_to que_path(current_user.count)
          flash[:danger] = "Sorry you can't visit other pages while giving a test"
        else
          redirect_to gettest_path
          flash[:danger] = "To leave the test click on the button at bottom of the page"
        end
      end
    end
  end

end
