class QuesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :stay, only: [:show]
  before_action :not_allowed, only: [:show]
  before_action :test_started, only: [:index]
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
      current_user.update_attributes(count: 1, under_test: 1, freq: current_user.freq + 1)
      exam = Exam.find(current_user.exam_id)
      i=0
      a = Array.new
      exam.categorys.each do |cat|
        a[i] = cat.id
        i = i + 1
      end
      no = rand(0..(a.size-1))
      score = Score.create(user_id: current_user.id, mark: 0, attempt: current_user.freq, exam_id: current_user.exam_id, last: -1, category_id: 1)
    else
      score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
      if current_user.redi==0
        current_user.update_attributes(count: current_user.count + 1)
      end
    end

=begin    
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
=end    
    @p = current_user.count
    @present_cat = Exam.find(score.exam_id).topic
    @pres_cat = Category.find(score.category_id)
    if score.last==-1
      if current_user.redi==-1 || current_user.redi==2
        @present_ques = Que.find(score.ques_id)
        @sheet = Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0)
        @sheet ||= Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
        @attempt = Attempt.find(current_user.attempt_id)
        @ability = @attempt.ability
        @score = score
        if current_user.redi==2
          current_user.update_attributes(redi: 0)
        end
      else
        i=1
        c=0
        if Attempt.last
          d = Attempt.last.id
        end
        d ||= 0
        while i<=d do
          if Attempt.find(i).user_id==current_user.id && Attempt.find(i).exam_id==current_user.exam_id
            c=c+1
          end
          i=i+1
        end
        current_user.update_attributes(attempt_id: Attempt.create(user_id: current_user.id, exam_id: current_user.exam_id, freq: c + 1).id)
        @attempt = Attempt.find(current_user.attempt_id)
        @attempt.update_attributes(ability: 3)
        a = Array.new
        i=3
        while @queslines.blank? do
          @queslines = Que.where(category_id: score.category_id, diff: 3)
        end
        i=0
        @queslines.each do |quesline|
          a[i] = quesline.id
          i = i + 1
        end
        @ability = @attempt.ability
        no = rand(0..(a.size-1))
        que = Que.find_by(id: a[no])
        @present_ques = que
        @sheet = Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
        @score = score
      end
    else
      if current_user.redi==-1 || current_user.redi==2
        @present_ques = Que.find(score.ques_id)
        @sheet = Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: score.ques_id, updated: 0)
        @sheet ||=Sheet.create(attempt_id: current_user.attempt_id, ques_id: score.ques_id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id)
        @attempt = Attempt.find(current_user.attempt_id)
        @ability = @attempt.ability
        @score = score
        if current_user.redi==2
          current_user.update_attributes(redi: 0)
        end
      else
        @attempt = Attempt.find(current_user.attempt_id)
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
        @attempt = Attempt.find(current_user.attempt_id)
        @attempt.update_attributes(ability: b + (correct_count - s)/t)
        min = Float::INFINITY
        b = @attempt.ability
        pre_id = 0
        exam = Exam.find(Attempt.find(current_user.attempt_id).exam_id)
        exam.ques.each do |que|
          if que.diff!=nil
            difference = ((b - que.diff).abs).to_f
            if difference<min && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: que.id, updated: 1)
              min = difference
              pre_id = que.id
            end
          end
        end
        @ability = @attempt.ability
        @present_ques = Que.find(pre_id)
        @sheet = Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id, category_id: @present_ques.category_id)
        @score = score
      end
    end





















































=begin    
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
=end





















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
  def stay
    if current_user.count>0
      score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
      if params[:id].to_i==current_user.count && Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: score.ques_id, updated: 0) && current_user.redi!=2 && current_user.redi!=-1
        current_user.update_attributes(redi: 2)
        redirect_to que_path(current_user.count)
      else
        if current_user.redi==1
          current_user.update_attributes(redi: -1)
        else
          if (params[:id].to_i - 1)!=current_user.count && current_user.redi!=2 && current_user.redi!=-1
            current_user.update_attributes(redi: 1)
            redirect_to que_path(current_user.count)
          end
        end
      end
    end
  end
  def not_allowed
    if current_user.under_test!=1 || current_user.exam_id==nil
      flash[:danger] = "Sorry, you can't enter the test like that !"
      redirect_to root_path
    end
  end
  def test_started
    if current_user.under_test!=1
      flash[:danger] = "Sorry you cannot enter the test like this"
      redirect_to root_path
    elsif (current_user.exam_id==nil || current_user.exam_id==0) && params[:exam]==nil
      redirect_to gettest_path
    elsif current_user.count>0
      current_user.update_attributes(redi: 2)
      redirect_to que_path(current_user.count)
    end
  end
  def cant_go_back
    if current_user.under_test==0 && current_user.redi==0
      flash[:danger] = "Sorry you cannot go directly"
      redirect_to user_path(current_user)
    end
  end
=begin
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
=end
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end