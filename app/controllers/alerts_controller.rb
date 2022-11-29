class AlertsController < ApplicationController
  before_action :set_alert, only: %i[ show like edit update destroy ]
  before_action :authenticate_user!, only: %i[ like ]

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
    # @marker = {
    #   lat: @alert.geocode[0],
    #   lng: @alert.geocode[1],
    #   image_url: helpers.asset_url("pin.png")
    # }
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
    @alert.upvotes = 0
    @alert.status = 0
    @alert.creator_id = current_user.id
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

  def like
    if current_user.voted_for? @alert
      @alert.unliked_by current_user
    else
      @alert.liked_by current_user
    end
    redirect_to alert_path(@alert)
  end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  end

  def alert_params
    params.require(:alert).permit(:title, :category, :address, :description, :upvotes, :status, photos: [])
  end
end
