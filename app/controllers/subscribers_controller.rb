class SubscribersController < ApplicationController
  def create
    @alert = Alert.find(params[:alert_id])
    @subscriber = Subscriber.new(alert_id: @alert.id, subscriber_id: current_user.id)
    @subscriber.save!
    redirect_to alert_path(@alert)
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy
    redirect_to alert_path(@alert.id)
  end
end
