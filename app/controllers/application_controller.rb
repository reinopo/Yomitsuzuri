class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || user_path(resource)
  end

  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
