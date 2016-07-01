class SheetsController < ApplicationController
  before_action :logged_in_user, only: [:update]
  before_action :cant_go_back, only: [:update]
  def new
  end
  def update
    @attempt = Attempt.find(current_user.attempt_id)
    @score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
    @sheet = Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: @score.ques_id)
    @ques = Que.find_by(id: @score.ques_id)
    a=0
    if current_user.count==1
      if !File.exist?"public/headshots/#{current_user.id}_#{current_user.freq}_#{current_user.count}.jpg"
        current_user.update_attributes(redi: -1)
        redirect_to que_path(current_user.count)
        return
      else
        current_user.update_attributes(redi: 0)
      end
    end
    if current_user.count%6==1
      if !File.exist?"public/headshots/#{current_user.id}_#{current_user.freq}_#{current_user.count}.jpg"
        current_user.update_attributes(redi: -1)
        redirect_to que_path(current_user.count)
        return
      else
        current_user.update_attributes(redi: 0)
      end
    end
    if @sheet.update_attributes(sheet_params)
      @sheet.update_attributes(updated: 1)
    end
    if @ques.correct.include?('1')
      if @sheet.one!=true
        a=1
      end
    else
      if @sheet.one==true
        a=1
      end
    end
    if @ques.correct.include?('2')
      if @sheet.two!=true
        a=1
      end
    else
      if @sheet.two==true
        a=1
      end
    end
    if @ques.correct.include?('3')
      if @sheet.three!=true
        a=1
      end
    else
      if @sheet.three==true
        a=1
      end
    end
    if @ques.correct.include?('4')
      if @sheet.four!=true
        a=1
      end
    else
      if @sheet.four==true
        a=1
      end
    end
    if current_user.redi!=-1
      if a==0
        @score.update_attributes(mark: @score.mark + 3, last: 1)
        @ques.update_attributes(correct_attempt: @ques.correct_attempt + 1)
        @sheet.update_attributes(correct: true)
      else
        @score.update_attributes(mark: @score.mark - 1, last: 0)
        @ques.update_attributes(wrong_attempt: @ques.wrong_attempt + 1)
        @sheet.update_attributes(correct: false)
      end
    end
    @queslines = Que.where(exam_id: @score.exam_id)
    if current_user.count==12
      b = @attempt.ability
      s = 0
      t = 0
      correct_count = 0
      Sheet.where("attempt_id = ?", current_user.attempt_id).each do |a|
        question = Que.find(a.ques_id)
        pm = (Math.exp(b - question.diff)/(1 + Math.exp(b - question.diff)))
        s = s + pm
        t = t + pm * (1 - pm)
        if (a.correct?)
          correct_count += 1
        end
      end
      @attempt.update_attributes(ability: b + (correct_count - s)/t)
      redirect_to users_finish_path
    else
      redirect_to que_path(current_user.count + 1)
    end
  end
  private
  def sheet_params
    params.require(:sheet).permit(:one, :two, :three, :four)
  end
  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def cant_go_back
    if current_user.under_test==0
      redirect_to user_path(current_user)
      flash.now[:danger] = "Sorry you cannot go like that"
    end
  end
end
