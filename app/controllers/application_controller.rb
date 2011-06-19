class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_language

  def can_access?
    current_user.id == @note.user_id
  end


  private
  def set_language
    if !current_user.nil?
      I18n.locale = current_user.language || I18n.default_locale
    end
  end
end

