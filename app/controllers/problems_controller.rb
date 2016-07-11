class ProblemsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  def new
    @problem = Problem.new
  end
  def create
    @problem = Problem.new(problem_params)
    if @problem.save
      @problem.update_attributes(user_id: current_user.id)
      flash[:success] = "Your response has been recorded"
      redirect_to root_path
    else
      render 'new'
    end
  end
  private
  def problem_params
    params.require(:problem).permit(:email, :query)
  end
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
