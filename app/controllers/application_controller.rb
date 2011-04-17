class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :update_username
  def can_access?
    current_user.id == @note.user_id
  end

private

  def update_username
    if !current_user.nil?
     redirect_to(edit_user_registration_url(current_user)) if current_user.username.blank?
    end
  end

end

