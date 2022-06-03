class ApplicationController < ActionController::Base
  #deviseの記述はここに
  before_action :configure_permitted_parameters, if: :devise_controller? #ストトングパラメーター
  
  def after_sign_in_path_for(resource) #(resource)は必ずセット
    home_about_path
  end 
  
  def after_sign_out_path_for(resource)
    root_path
  end 
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email]) 
    #sign_up時、nameの保存に許可をする=>config/initilizers/devise.rbで基準をnameにしているためここは[:email]にする
  end
end
