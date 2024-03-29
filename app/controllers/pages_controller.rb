class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    redirect_to alerts_path if user_signed_in? && current_user.role == "worker"
    @contact = Contact.new
    @alerts = Alert.all
    @markers = @alerts.geocoded.map do |alert|
      {
        lat: alert.latitude,
        lng: alert.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { alert: alert } )
      }
    end
  end

  def about
  end
end
