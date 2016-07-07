class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show, :gettest, :reset]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :refresh_diff, :update_count]
  before_action :stay, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :not_allowed, only: [:finish]
  before_action :cant_start_again, only: [:gettest]
  #before_action :cant_go_to_finish, only: [:finish]
  #before_action :cant_visit_other_pages, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  def index
    flash[:danger]="Not allowed"
    redirect_to root_url
    #@users = User.paginate(page: params[:page])
  end
  def show
  	@user = User.find(params[:id])
    @attempts = Attempt.where(user_id: current_user.id)
    @exams = Exam.all
  end
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.update_attributes(under_test: 0, redi: 0, exam_id: 0, count: 0, attempt_id: 0, freq: 0)
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
  	else
  		render 'new'
  	end
  end
  def edit
  end
  def gettest
    @exams = Exam.all
    current_user.update_attributes(under_test: 1)
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user#Handle a successful edit
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  def finish
    if current_user.count>0
      @exam = Exam.find(current_user.exam_id)
      @score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
      @attempt = Attempt.find(current_user.attempt_id)
      @ability = @attempt.ability
      @attempts = Attempt.where(exam_id: @exam.id)
      c = @attempts.count
      s=0
      @attempts.each do |attempt|
        s = s + attempt.ability
      end
      @exam.update_attributes(average: s/c)
      current_user.update_attributes(exam_id: 0, under_test: 0, count: 0, redi: 0, attempt_id: 0)
      @user = current_user
    else
      current_user.update_attributes(exam_id: 0, under_test: 0, count: 0, redi: 0, attempt_id: 0)
      flash[:danger] = "You have left the test"
      redirect_to root_path
    end
  end
  def refresh_diff
    @ques = Que.all
    @ques.each do |que|
      if que.no_attempt>0
        a = que.no_attempt/(que.no_attempt + 50)
        if a<0.5
          new_diff = (1-a)*que.diff + a*que.wrong_attempt*10/que.no_attempt
          que.update_attributes(diff: new_diff)
        else
          new_diff = a*que.diff + (1-a)*que.wrong_attempt*10/que.no_attempt
          que.update_attributes(diff: new_diff)
        end
      end
    end
    flash[:success] = "Difficulties have beeen updated"
    redirect_to user_path(current_user)
  end
  def update_count
    i=1
    while i<=6 do
      exam = Exam.find(i)
      exam.update_attributes(no: 0, very_easy: 0, easy: 0, medium: 0, difficult: 0, very_difficult: 0)
      i=i+1
    end
    i=1
    while i<=6 do
      exam = Exam.find(i)
      ques = Que.where(exam_id: i)
      ques.each do |que| 
        if que.diff<=2
          exam.update_attributes(no: exam.no + 1, very_easy: exam.very_easy + 1)
        elsif que.diff>2 && que.diff<=4
          exam.update_attributes(no: exam.no + 1, easy: exam.easy + 1)
        elsif que.diff>4 && que.diff<=6
          exam.update_attributes(no: exam.no + 1, medium: exam.medium + 1)
        elsif que.diff>6 && que.diff<=8
          exam.update_attributes(no: exam.no + 1, difficult: exam.difficult + 1)
        elsif que.diff>8  && que.diff<=10
          exam.update_attributes(no: exam.no + 1, very_difficult: exam.very_difficult + 1)
        end
      end
      i=i+1
    end
    flash[:success] = "Questions count was successfully updated"
    redirect_to user_path(current_user)
  end
  def reset
    current_user.update_attributes(under_test: 0, exam_id: 0, redi: 0, count: 0)
    Misc.where(user_id: current_user.id).each do |mi|
      mi.destroy
    end
    flash[:success] = "You are good to attend the test again"
    redirect_to root_path
  end
  private
  def user_params
  	params.require(:user).permit(:name, :email, :mobileno, :classten, :classtwelve, :achievements, :experience, :projects, :password, :password_confirmation)
  end
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
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
  def not_allowed
    if current_user.under_test!=1 && current_user.count<=0
      flash[:danger] = "Sorry, you can't enter the test like that !"
      redirect_to root_path
#    elsif current_user.exam_id==nil || current_user.exam_id==0
 #     redirect_to gettest_path
  #  elsif current_user.count==0
   #   redirect_to ques_path
    end
  end
  def cant_start_again
    if current_user.under_test==1 && (current_user.exam_id!=nil && current_user.exam_id!=0)
      if current_user.count==0
        redirect_to ques_path
      else
        current_user.update_attributes(redi: 2)
        redirect_to que_path(current_user.count)
      end
    end
  end
  def cant_go_to_finish
    if current_user.under_test==0
      redirect_to user_path(current_user)
      flash[:danger] = "Sorry you have to start a test to see your result on the finish page"
    end
  end
  def cant_visit_other_pages
    if current_user.under_test==1
      if current_user.count==0
        flash[:danger] = "You cannot visit other pages while giving a test"
        redirect_to gettest_path
      else
        flash[:danger] = "You cannot visit other pages while giving a test"
        redirect_to que_path(current_user.count)
      end
    end
  end
end
