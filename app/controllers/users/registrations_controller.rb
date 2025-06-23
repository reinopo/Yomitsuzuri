# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout "application"
  before_action :configure_permitted_parameters

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if update_resource(resource, account_update_params)
      flash[:profile_notice] = "プロフィールを更新しました！"
      bypass_sign_in resource, scope: resource_name
      redirect_to home_mypage_path, status: :see_other
    else
      clean_up_passwords resource
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy
    flash[:profile_notice] = "アカウントを削除しました。"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :avatar])
  end

  # プロフィール変更のみパスワードなしで可能
  def update_resource(resource, params)
    if params[:password].present?
      super
    else
      resource.update_without_password(params.except(:current_password))
    end
  end

  def after_update_path_for(resource)
    home_mypage_path
  end
  
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
