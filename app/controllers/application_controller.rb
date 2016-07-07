class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  helper :headshot
  def headshot_custom_file_path
    file_name = "#{current_user.id}_#{current_user.freq}_#{current_user.count}.jpg"
    File.join(Rails.root, 'public', 'headshots', file_name)
  end

  def headshot_custom_image_url(file_name)
    'http://' + request.host_with_port + '/headshots/' + file_name
  end

  def headshot_post_save(file_path)
    @headshot_photo = HeadshotPhoto.new
    @headshot_photo.tryimage = File.new(file_path)
    @headshot_photo.save
  end
end
