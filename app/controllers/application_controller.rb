class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top] #ログインしていない状態でトップページ以外のアクセスされた場合は、ログイン画面へリダイレクトするように設定
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
