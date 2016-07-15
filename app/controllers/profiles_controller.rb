class ProfilesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show, :edit, :update, :index, :destroy]
  before_action :admin_user, only: [:new, :create, :show, :edit, :update, :index, :destroy]
  def new
    @exams = Exam.all
    @profile = Profile.new
    if session[:incorrect] == 1
      flash[:danger] = "Invalid Name or Exams field"
    end
  end
  def create
    @a = profile_params
    @profile = Profile.new(@a)
    if @profile.save
      flash[:success] = "Successful"
      redirect_to @profile
    else
      session[:incorrect] = 1
      redirect_to createprofile_path
    end
  end
  def show
    @profile = Profile.find(params[:id])
  end
  def edit
    @exams = Exam.all
    @profile = Profile.find(params[:id])
  end
  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(profile_params)
      flash[:success] = "Updated"
      redirect_to @profile
    else
      flash[:danger] = "Not Updated"
      render 'edit'
    end
  end
  def index
    @profiles = Profile.all
  end
  def destroy
    Profile.find(params[:id]).destroy
    flash[:success] = "Profile deleted"
    redirect_to profiles_url
  end
  private
  def profile_params
    params.require(:profile).permit(:name, :exams)
  end
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
