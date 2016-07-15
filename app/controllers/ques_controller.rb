class QuesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :stay, only: [:show]
  before_action :not_allowed, only: [:show]
  before_action :test_started, only: [:index]
  ##before_action :cant_go_back, only: [:show, :index]
  ##before_action :cant_go_to_random_position, only: [:show]
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
    if current_user.count==0
      current_user.update_attributes(count: 1, under_test: 1)
      profile = Profile.find(current_user.profile_id)
      session[:exam_counter] = profile.exams.size
      c = 0
      Attempt.all.each do |attempt|
        if attempt.user_id==current_user.id && attempt.profile_id == profile.id
          c = c + 1
        end
      end
      biggest = -1
      as = Hash[profile.exams.map.with_index.to_a]
      Attempt.all.each do |attempt|
        if attempt.user_id==current_user.id && attempt.profile_id == profile.id && attempt.freq == current_user.freq
          if biggest < as[attempt.exam_id.to_s]
            biggest = as[attempt.exam_id.to_s]
          end
        end
      end
      att = Attempt.create(user_id: current_user.id, profile_id: current_user.profile_id, freq: current_user.freq, start_time: Time.zone.now, exam_id: profile.exams[biggest + 1].to_i)
      current_user.update_attributes(exam_id: profile.exams[biggest + 1].to_i, attempt_id: att.id)
      exam = Exam.find(current_user.exam_id)
      i=0
      a = Array.new
      session[:no] = Array.new
      session[:cat] = Array.new
      exam.categorys.each do |cat|
        a[i] = cat.id
        session[:no][i] = 0
        session[:cat][i] = cat.id
        i = i + 1
      end
      session[:zack] = i - 1
      no = rand(0..(a.size-1))
      score = Score.create(user_id: current_user.id, mark: 0, attempt: current_user.freq, exam_id: current_user.exam_id, last: -1, category_id: exam.categorys.first.id, profile_id: current_user.profile_id)
    else
      score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id, profile_id: current_user.profile_id)
      if current_user.redi==0
        current_user.update_attributes(count: current_user.count + 1)
      end
    end
    @ti = Exam.find(current_user.exam_id).topic
    @current_profile = Profile.find(current_user.profile_id)

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
        @sheet ||= Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0, profile_id: current_user.profile_id)
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
=begin
        if Attempt.last
          d = Attempt.last.id
        end
        d ||= 0
        while i<=d do
          if !!Attempt.find_by(id: i)
            if Attempt.find(i).user_id==current_user.id && Attempt.find(i).exam_id==current_user.exam_id
              c=c+1
            end
          end
          i=i+1
        end
        current_user.update_attributes(attempt_id: Attempt.create(user_id: current_user.id, exam_id: current_user.exam_id, freq: c + 1, start_time: Time.zone.now).id)
=end
        @attempt = Attempt.find(current_user.attempt_id)
        @attempt.update_attributes(ability: 3)
        a = Array.new
        i=3
        exam = Exam.find(current_user.exam_id)
        while @queslines.blank? do
          @queslines = exam.ques.where(diff: 3)
          if @queslines.blank?
            @queslines = exam.ques.where(diff: 2)
          end
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
        hash = Hash[session[:cat].map.with_index.to_a]
        session[:no][hash[@present_ques.category_id]] += 1
        @sheet = Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0, profile_id: current_user.profile_id)
        score.update_attributes(ques_id: @present_ques.id)
        @score = score
      end
    else
      if current_user.redi==-1 || current_user.redi==2
        @present_ques = Que.find(score.ques_id)
        @sheet = Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: score.ques_id, updated: 0, profile_id: current_user.profile_id)
        @sheet ||=Sheet.create(attempt_id: current_user.attempt_id, ques_id: score.ques_id, updated: 0, profile_id: current_user.profile_id)
        score.update_attributes(ques_id: @present_ques.id)
        @attempt = Attempt.find(current_user.attempt_id)
        @ability = @attempt.ability
        @score = score
        if current_user.redi==2
          current_user.update_attributes(redi: 0)
        end
      else
        @attempt = Attempt.find(current_user.attempt_id)
        if Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: score.ques_id, updated: 1, profile_id: current_user.profile_id).correct? && @attempt.ques_correct != nil
          @attempt.update_attributes(ability: session[:if_correct_ability])
          @present_ques = Que.find(@attempt.ques_correct)
          hash = Hash[session[:cat].map.with_index.to_a]
          session[:no][hash[@present_ques.category_id]] += 1
          @ability = @attempt.ability
          @sheet = Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0, profile_id: current_user.profile_id)
          score.update_attributes(ques_id: @present_ques.id, category_id: @present_ques.category_id)
          @score = score
        elsif !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: score.ques_id, updated: 1, profile_id: current_user.profile_id).correct? && @attempt.ques_incorrect != nil
          @attempt.update_attributes(ability: session[:if_incorrect_ability])
          @present_ques = Que.find(@attempt.ques_incorrect)
          hash = Hash[session[:cat].map.with_index.to_a]
          session[:no][hash[@present_ques.category_id]] += 1
          @ability = @attempt.ability
          @sheet = Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0, profile_id: current_user.profile_id)
          score.update_attributes(ques_id: @present_ques.id, category_id: @present_ques.category_id)
          @score = score
        else
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
          if b + (correct_count - s)/t > 10
            @attempt.update_attribute(ability: 10)
          elsif b + (correct_count - s)/t < -10
            @attempt.update_attributes(ability: -10)
          else
            @attempt.update_attributes(ability: b + (correct_count - s)/t)
          end
=begin
        if @attempt.ability >= -0.5 && @attempt.ability<5.5
          rounded_part = @attempt.ability.round
        elsif @attempt.ability >= 5.5
          rounded_part = 5
        else
          rounded_part = 0
        end
        @queslines = Que.where(diff: rounded_part)
        b = Array.new
        j = -1
        @queslines.each do |quesline|
          if !b.include?(quesline.category_id)
            j = j + 1
            b[j] = quesline.category_id
          end
        end
        b.sort!
        prev_cat_id = Que.find(score.ques_id).category_id
        f=0
        store = -1
        count = 0
        while f!=1 do
          if b[count]>prev_cat_id
            f = 1
          elsif b[count]==prev_cat_id
            if count!=j
              count = count + 1
            else
              count=0
            end
            f = 1
          else
            count = count + 1
          end
        end
        store = count
        compare = b[count]
        a = Array.new
        i = 0
        g=0
        while a.blank? && g==0 do
          @queslines.each do |quesline|
            if quesline.category_id==compare && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: quesline.id, updated: 1)
              a[i] = quesline.id
              i = i + 1
            end
          end
          if compare==j
            count = 0
          else
            count = count + 1
          end
          compare = b[count]
          if count==store
            g=1
          end
        end
        no = rand(0..(a.size-1))
=end
          min = Float::INFINITY
          b = @attempt.ability
          pre_id = 0
          j = 0
          bt = Array.new
          exam = Exam.find(Attempt.find(current_user.attempt_id).exam_id)
          exam.ques.each do |que|
            if que.diff!=nil
              difference = ((b - que.diff).abs).to_f
              if difference<min && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: que.id, updated: 1)
                min = difference
              end
            end
          end
          i = 0
          a = Array.new
          exam.ques.each do |que|
            if que.diff!=nil
              difference = ((b - que.diff).abs).to_f
              if difference==min && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: que.id, updated: 1)
                a[i] = que.id
                i = i + 1
              end
=begin
            if difference<=1 && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: que.id, updated: 1)
              bt[j] = que.id
              j = j + 1
            end
=end
            end
          end
          prev_cat_id = Que.find(score.ques_id).category_id
          exam = Exam.find(current_user.exam_id)
=begin
        k = 0
        t = Array.new
        exam.categorys.each do |cat|
          t[k] = cat.id
          k = k + 1
        end
        t.sort!
=end
          cat_ques = Array.new
          j = 0
          z = 0
          while j<i do
            if !cat_ques.include?(Que.find(a[j]).category_id)
              cat_ques[z] = Que.find(a[j]).category_id
              z = z + 1
            end
            j = j + 1
          end
          cat_ques.sort!
          counter = 0
          arc = Array.new
          z = 0
          session[:no], session[:cat] = session[:no].zip(session[:cat]).sort.transpose
          while counter <= session[:zack] do
            value = session[:cat][counter]
            if cat_ques.include?(value)
              k = 0
              z = 0
              while k<i do
                if Que.find(a[k]).category_id == session[:cat][counter]
                  arc[z] = a[k]
                  z = z + 1
                end
                k = k + 1
              end
            end
            if !arc.blank?
              break
            end
            counter = counter + 1
          end
          no = rand(0..(arc.size-1))
          @present_ques = Que.find(arc[no])
          hash = Hash[session[:cat].map.with_index.to_a]
          session[:no][hash[@present_ques.category_id]] += 1
          @ability = @attempt.ability
          @sheet = Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0, profile_id: current_user.profile_id)
          score.update_attributes(ques_id: @present_ques.id, category_id: @present_ques.category_id)
          @score = score
        end
      end
    end





=begin
        f=0
        count = 0
        while f!=1 do
          if t[count]>prev_cat_id
            f=1
          elsif t[count]==prev_cat_id
            if count==k-1
              count = 0
            else
              count = count + 1
            end
            f=1
          else
            count = count + 1
          end
        end
        ar = Array.new
        w=0
        l=0
        store = count
        g=0
        ag=0
        while g==0 do
          while w!=j do
            if Que.find(bt[w]).category_id==t[count]
              ar[l] = bt[w]
              l = l + 1
            end
            w = w + 1
          end
          if count==k-1
            count=0
          else
            count = count + 1
          end
          if count==store
            g=1
          end
          if !ar.blank?
            g=1
            ag=1
          end
        end
        if ag==1 && @attempt.ability<5.5
          no = rand(0..(ar.size-1))
          @present_ques = Que.find(ar[no])
        else
          no = rand(0..(a.size-1))
          @present_ques = Que.find(a[no])
        end
        @ability = @attempt.ability
        @sheet = Sheet.create(attempt_id: current_user.attempt_id, ques_id: @present_ques.id, updated: 0)
        score.update_attributes(ques_id: @present_ques.id, category_id: @present_ques.category_id)
        @score = score
      end
    end
=end




















































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
    @attempt.update_attributes(ques_correct: nil, ques_incorrect: nil)
  end
  def index
    if Misc.find_by(user_id: current_user.id, attempt: current_user.freq + 1) && current_user.profile_id!=nil && current_user.profile_id!=0
      @profile = Profile.find(current_user.profile_id)
      @misc = Misc.find_by(user_id: current_user.id, attempt: current_user.freq + 1)
    else
      current_user.update_attributes(freq: current_user.freq + 1 )
      @profile = Profile.find(params[:profile])
      current_user.update_attributes(profile_id: params[:profile])
      @misc = Misc.create(user_id: current_user.id, attempt: current_user.freq + 1, terms: false)
    end
  end
  def just_fake
    redirect_to "http://localhost:3000/headshot_demo/index"
  end
  def ready
    score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id)
    attempt = Attempt.find(current_user.attempt_id)
    b = attempt.ability
    s = 0
    t = 0
    correct_count = 0
    Sheet.where("attempt_id = ?", current_user.attempt_id).each do |a|
      question = Que.find(a.ques_id)
      pm = (Math.exp(b - question.diff)/(1 + Math.exp(b - question.diff)))
      s = s + pm
      t = t + pm * (1 - pm)
      if a.correct == true
        correct_count += 1
      end
    end
    if b + (correct_count + 1 - s)/t > 10
      if_correct_ability = 10
    elsif b + (correct_count + 1 - s)/t < -10
      if_correct_ability = -10
    else
      if_correct_ability = b + (correct_count + 1 - s)/t
    end

    if b + (correct_count - s)/t > 10
      if_incorrect_ability = 10
    elsif b + (correct_count - s)/t < -10
      if_incorrect_ability = -10
    else
      if_incorrect_ability = b + (correct_count - s)/t
    end
    session[:if_correct_ability] = if_correct_ability
    session[:if_incorrect_ability] = if_incorrect_ability
    min = Float::INFINITY
    b = if_correct_ability
    pre_id = 0
    j = 0
    bt = Array.new
    exam = Exam.find(Attempt.find(current_user.attempt_id).exam_id)
    exam.ques.each do |que|
      if que.diff!=nil
        difference = ((b - que.diff).abs).to_f
        if difference<min && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: que.id, updated: 1)
          min = difference
        end
      end
    end
    i = 0
    a = Array.new
    exam.ques.each do |que|
      if que.diff!=nil
        difference = ((b - que.diff).abs).to_f
        if difference==min && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: que.id, updated: 1)
          a[i] = que.id
          i = i + 1
        end
      end
    end
    prev_cat_id = Que.find(score.ques_id).category_id
    exam = Exam.find(current_user.exam_id)
    cat_ques = Array.new
    j = 0
    z = 0
    while j<i do
      if !cat_ques.include?(Que.find(a[j]).category_id)
        cat_ques[z] = Que.find(a[j]).category_id
        z = z + 1
      end
      j = j + 1
    end
    cat_ques.sort!
    counter = 0
    arc = Array.new
    z = 0
    session[:no], session[:cat] = session[:no].zip(session[:cat]).sort.transpose
    while counter <= session[:zack] do
      value = session[:cat][counter]
      if cat_ques.include?(value)
        k = 0
        z = 0
        while k<i do
          if Que.find(a[k]).category_id == session[:cat][counter]
            arc[z] = a[k]
            z = z + 1
          end
          k = k + 1
        end
      end
      if !arc.blank?
        break
      end
      counter = counter + 1
    end
    no = rand(0..(arc.size-1))
    attempt.update_attributes(ques_correct: arc[no])
    #For Incorrect attempt
    min = Float::INFINITY
    b = if_incorrect_ability
    pre_id = 0
    j = 0
    bt = Array.new
    exam = Exam.find(Attempt.find(current_user.attempt_id).exam_id)
    exam.ques.each do |que|
      if que.diff!=nil
        difference = ((b - que.diff).abs).to_f
        if difference<min && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: que.id, updated: 1)
          min = difference
        end
      end
    end
    i = 0
    a = Array.new
    exam.ques.each do |que|
      if que.diff!=nil
        difference = ((b - que.diff).abs).to_f
        if difference==min && !Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: que.id, updated: 1)
          a[i] = que.id
          i = i + 1
        end
      end
    end
    prev_cat_id = Que.find(score.ques_id).category_id
    exam = Exam.find(current_user.exam_id)
    cat_ques = Array.new
    j = 0
    z = 0
    while j<i do
      if !cat_ques.include?(Que.find(a[j]).category_id)
        cat_ques[z] = Que.find(a[j]).category_id
        z = z + 1
      end
      j = j + 1
    end
    cat_ques.sort!
    counter = 0
    arc = Array.new
    z = 0
    session[:no], session[:cat] = session[:no].zip(session[:cat]).sort.transpose
    while counter <= session[:zack] do
      value = session[:cat][counter]
      if cat_ques.include?(value)
        k = 0
        z = 0
        while k<i do
          if Que.find(a[k]).category_id == session[:cat][counter]
            arc[z] = a[k]
            z = z + 1
          end
          k = k + 1
        end
      end
      if !arc.blank?
        break
      end
      counter = counter + 1
    end
    no = rand(0..(arc.size-1))
    attempt.update_attributes(ques_incorrect: arc[no])
  end

  helper_method :ready

  def nextpart
    session[:waiting] = 0
    redirect_to que_path(1)
  end
  def gofinish
  end
  def nextset
  end
  private
  def stay
    if session[:waiting] == 1
      redirect_to users_finish_path
    else
      if current_user.count>0
        score = Score.find_by(user_id: current_user.id, attempt: current_user.freq, exam_id: current_user.exam_id, profile_id: current_user.profile_id)
        if params[:id].to_i==current_user.count && Sheet.find_by(attempt_id: current_user.attempt_id, ques_id: score.ques_id, updated: 0, profile_id: current_user.profile_id) && current_user.redi!=2 && current_user.redi!=-1
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
  end
  def not_allowed
    if current_user.under_test!=1 || current_user.profile_id==nil
      flash[:danger] = "Sorry, you can't enter the test like that !"
      redirect_to root_path
    end
  end
  def test_started
    if session[:waiting] == 1
      redirect_to users_finish_path
    else
      if current_user.under_test!=1
        flash[:danger] = "Sorry you cannot enter the test like this"
        redirect_to root_path
      elsif (current_user.profile_id==nil || current_user.profile_id==0) && params[:profile]==nil
        redirect_to gettest_path
      elsif current_user.count>0
        current_user.update_attributes(redi: 2)
        redirect_to que_path(current_user.count)
      end
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
