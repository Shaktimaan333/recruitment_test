class MiscsController < ApplicationController
  def new
  end
  def update
    misc = Misc.find_by(user_id: current_user.id, attempt: current_user.freq + 1)
    misc.update_attributes(misc_params)
    if misc.terms==true
      redirect_to que_path(1)
    else
      flash[:danger] = "To proceed further, please agree to terms and conditions"
      redirect_to ques_path
    end
  end
  private
  def misc_params
    params.require(:misc).permit(:terms)
  end
end
