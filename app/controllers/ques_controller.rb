class QuesController < ApplicationController
  before_action :logged_in_user, only: [:new, :index, :show]
  #before_action :cant_go_back, only: [:show, :index]
  #before_action :cant_go_to_random_position, only: [:show]
  def new
  end
  def show
    #if current_user.count==1
     # score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
      #if score.last!=-1 && (!File.exist?"/Users/architaggarwal/workspace/exam_app/public/headshots/#{current_user.id}_#{current_user.freq}_#{current_user.count}.jpg")
       # current_user.update_attributes(redi: -1)
        #score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
#        score.update_attributes(last: -1, mark: 0)
 #       redirect_to que_path(1)
  #    end
   #   if current_user.redi==-1 && score.last!=-1
    #    current_user.update_attributes(redi: 0)
     # end
  #  end
    @ti = Exam.find(current_user.exam_id).topic
    if current_user.count==0
      current_user.update_attributes(count: 1, freq: current_user.freq+1, under_test: 1)
      pexam = Exam.find(current_user.exam_id)
      pexam.update_attributes(category_name: pexam.category_name + "  ")
      i=0
      str = ""
      while pexam.category_name[i]!=' ' || pexam.category_name[i+1]!=' ' do
        str = str + pexam.category_name[i]
        i=i+1
      end
      score = Score.create(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id, mark: 0, last: -1, category_id: Category.find_by(name: str).id, cat_count: 1)
      @queslines = Que.where(category_id: score.category_id)
    else
      score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
      if current_user.redi==0
        current_user.update_attributes(count: current_user.count + 1)
        if current_user.count%6==1 && current_user.count!=1
          pexam = Exam.find(current_user.exam_id)
          i=0
          str = ""
          c = score.cat_count
          s = 0
          e = -3
          while c!=-1
            if pexam.category_name[i]==' ' && pexam.category_name[i+1]==' '
              c = c - 1
              s = e + 3
              e = i-1
              i = i + 1
            end
            i = i + 1
          end
          score.update_attributes(category_id: (Category.find_by(name: pexam.category_name[s..e])).id, cat_count: score.cat_count + 1)
        end
      end
      @queslines = Que.where(category_id: score.category_id)
    end
    @p = current_user.count
    @present_cat = Exam.find(score.exam_id).topic
    @pres_cat = Category.find(score.category_id)
    if score.last==-1
      if current_user.redi==-1
        @present_ques = Que.find(score.ques_id)
        @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
      else
        a = Array.new
        i=1
        @queslines = nil
        while @queslines.blank? do
          @queslines = Que.where(category_id: score.category_id, diff: i)
          i = i + 1
        end
        i=0
        @queslines.each do |quesline|
          i = i + 1
          a[i] = quesline.id
        end
        no = rand(0..(a.size-1))
        que = Que.find_by(id: a[no])
        @present_ques = que
        @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
      end
    else
      @prev_ques = Que.find(score.ques_id)
      i = @prev_ques.diff
      @queslines = nil
      a = Array.new
      while @queslines.blank? do
        if i==5
          i=1
        else
          i = i + 1
        end
        @queslines = Que.where(category_id: score.category_id, diff: i)
      end
      i = 0
      @queslines.each do |quesline|
        i = i + 1
        a[i] = quesline.id
      end
      no = rand(0..(a.size-1))
      que = Que.find_by(id: a[no])
      @present_ques = que
      @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
      score.update_attributes(ques_id: @present_ques.id)
    end























=begin
    if score.last==-1
      if current_user.redi==-1
        @prev_ques = Que.find(score.ques_id)
        @present_ques = @prev_ques
        @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
      else
        a = Array.new
        pre = score.value[2].to_i
        j=0
        while pre!=0
          j=j+1
          if Exam.find(j).diff==3
            pre = pre - 1
          end
        end
        @questions = Que.where(exam_id: j)
        @questions.each do |quesline|
          i=i+1
          a[i] = quesline.id
        end
        no = rand(0..(a.size-1))
        que = Que.find_by(id: a[no])
        @present_ques = que
        @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id, value: "11211")
      end
    elsif score.last==0
      a = Array.new
      prev_ques = Que.find(score.ques_id)
      pre = score.value[prev_ques.diff-1].to_i
      j=0
      while pre!=0
        j=j+1
        if Exam.find(j).diff==prev_ques.diff - 1
          pre = pre - 1
        end
      end
      @questions = Que.where(exam_id: j)
      if current_user.redi==-1
        @present_ques = prev_ques
        @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
      else
        if prev_ques.diff==1
          while a.blank?
            pre = score.value[prev_ques.diff].to_i
            j=0
            while pre!=0
              j=j+1
              if Exam.find(j).diff==prev_ques.diff - 1
                pre = pre - 1
              end
            end
            @questions = Que.where(exam_id: j)
            @questions.each do |quesline|
              if !Sheet.find_by(user_id: current_user.id, attempt: current_user.freq, ques_id: quesline.id, updated: 1)
                i=i+1
                a[i] = quesline.id
              end
            end
            st = (pre + 1).to_s
            score.update_attributes(value: s + score.value(0..))

        else
          inc_diff=1
          while a.blank? && (prev_ques.diff-inc_diff)>0 do
            i=-1
            @questions.each do |quesline|
              if quesline.diff==(prev_ques.diff - inc_diff) && !Sheet.find_by(user_id: current_user.id, attempt: current_user.freq, ques_id: quesline.id, updated: 1)
                i=i+1
                a[i] = quesline.id
              end
            end
            inc_diff = inc_diff + 1
          end
        end
        no = rand(0..(a.size-1))
        que = Que.find(a[no])
        @present_ques = que
        @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
      end
    else
      a = Array.new
      @questions = Que.where(exam_id: current_user.exam_id)
      prev_ques = Que.find(score.ques_id)
      if current_user.redi==-1
        @present_ques = prev_ques
        @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
      else
        if prev_ques.diff==10
          @questions.each do |quesline|
            if quesline.diff==10 && !Sheet.find_by(user_id: current_user.id, attempt: current_user.freq, ques_id: quesline.id, updated: 1)
              i=i+1
              a[i] = quesline.id
            end
          end
        else
          inc_diff=1
          while a.blank? && (prev_ques.diff+inc_diff)<=10 do
            i=-1
            @questions.each do |quesline|
              if quesline.diff==prev_ques.diff+inc_diff && !Sheet.find_by(user_id: current_user.id, attempt: current_user.freq, ques_id: quesline.id, updated: 1)
                i=i+1
                a[i] = quesline.id
              end 
            end
            inc_diff = inc_diff + 1
          end
        end
        no = rand(0..(a.size-1))
        que = Que.find(a[no])
        @present_ques = que
        @sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
      end
    end

    #@queslines.each do |quesline|
     # if i==0 && !Sheet.find_by(user_id: current_user.id, attempt: current_user.freq, ques_id: quesline.id, updated: 1)
      #  i=i+1
       # @present_ques = quesline
        #@sheet = Sheet.create(user_id: current_user.id, attempt: current_user.freq, ques_id: quesline.id, updated: 0)
       # score.update_attributes(ques_id: quesline.id)
        #render 'show'
     #      end
    #   end
=end
  end
  def index
    if Misc.find_by(user_id: current_user.id, attempt: current_user.freq + 1)
      @exam = Exam.find(current_user.exam_id)
      @misc = Misc.find_by(user_id: current_user.id, attempt: current_user.freq)
    else
      @exam = Exam.find(params[:exam])
      current_user.update_attributes(exam_id: params[:exam])
      @misc = Misc.create(user_id: current_user.id, attempt: current_user.freq + 1, terms: false)
    end
  end
  def just_fake
    redirect_to "http://localhost:3000/headshot_demo/index"
  end
  private
  def cant_go_back
    if current_user.under_test==0 && current_user.redi==0
      flash[:danger] = "Sorry you cannot go directly"
      redirect_to user_path(current_user)
    end
  end
  def cant_go_to_random_position
    if params[:id]!=nil
      a = params[:id].to_i
      if current_user.count>0
        @score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
      end
      if a==current_user.count && Sheet.find_by(user_id: current_user.id, attempt: current_user.freq, ques_id: @score.ques_id, updated: 0)
        current_user.update_attributes(redi: 1)
      else
        if a!=current_user.count+1 
          current_user.update_attributes(redi: 0, exam_id: 0, under_test: 0, count: 0)
          flash[:danger]="Your test has been cancelled as you were found cheating"
          redirect_to user_path(current_user)
        else
          current_user.update_attributes(redi: 0)
        end
      end
    end
  end
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end