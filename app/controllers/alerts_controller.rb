class AlertsController < ApplicationController
  def index
    @alerts = Alert.all
  end
end
