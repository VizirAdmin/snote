module ApplicationHelper
  def google_analytics
    render :partial => 'shared/analytics' if Rails.env == 'production'
  end
end
