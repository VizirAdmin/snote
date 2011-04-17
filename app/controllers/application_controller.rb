class ApplicationController < ActionController::Base
  protect_from_forgery
  def can_access?
    current_user.id == @note.user_id
  end

end

