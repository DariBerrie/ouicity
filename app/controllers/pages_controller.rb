class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
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

  def index
    @alerts = Alert.all
    @markers = @alerts.geocoded.map do |alert|
      {
        lat: alert.latitude,
        lng: alert.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { alert: alert } )
      }
    end
  end
end
