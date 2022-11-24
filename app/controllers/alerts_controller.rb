class AlertsController < ApplicationController
  before_action :set_alert, only: %i[ show edit update destroy ]

  # def index
  #   @alerts = Alert.all
  #   # if params[:query].present?
  #   #   @alerts = Alert.search_by_everything(params[:query])
  #   # else
  #   #   @alerts = Alert.all
  #   # end

  #   # @markers = @alerts.geocoded.map do |alert|
  #   #   {
  #   #     lat: alert.latitude,
  #   #     lng: alert.longitude,
  #   #     info_window: render_to_string(partial: "info_window", locals: { alert: alert }),
  #   #     image_url: helpers.asset_url("pin.png")
  #   #   }
  #   # end
  # end
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

  def show
    # @suggested_alerts = Alert.all.sample(8)
    # @marker = {
    #   lat: @alert.geocode[0], lng: @alert.geocode[1],
    #   image_url: helpers.asset_url("loopyex.png")
    # }
    # @time_ago = ((Time.new - @alert.created_at) / 1.day).round
  end

  def my_alerts
    @user = current_user
    @alerts = Alert.where(creator: @user)
  end

  def new
    @alerts = Alert.all
    @alert = Alert.new
  end

  def create
    @alert = Alert.create(alert_params)
    @alert.user = current_user
    if @alert.save
      redirect_to alert_path(@alert), notice: "Thank you for sending your alert."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @alert.update(alert_params)
      redirect_to alert_path(@alert), notice: "Alert updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @alert.destroy
    redirect_to alerts_path, status: :see_other
  end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  end

  def alert_params
    params.require(:alert).permit(:title, :category, :address, :description, :upvotes, :status, photos: [])
  end
end
