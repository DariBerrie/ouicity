class AlertsController < ApplicationController
  before_action :set_alert, only: %i[show like edit update destroy]
  before_action :authenticate_user!, only: %i[index like show new edit]

  def index
    if params[:query].present?
      @alerts = Alert.order(created_at: :desc).search_by_everything(params[:query])
    else
      @alerts = Alert.order(created_at: :desc)
    end
    @unresolved_alerts = Alert.where(status: "submitted").or(Alert.where(status: "in progress"))
    @markers = @alerts.geocoded.map do |alert|
      {
        lat: alert.latitude,
        lng: alert.longitude,
        info_window: render_to_string(partial: "shared/info_window", locals: { alert: alert } )
      }
    end
  end

  def show
    @workers = User.where(role: "worker")
    @marker = { lat: @alert.geocode[0], lng: @alert.geocode[1] }
    @assignment = Assignment.new
    @chatroom = @alert.chatroom
    @chat_message = ChatMessage.new
    @subscriber = @alert.subscribers.find { |s| s.subscriber_id == current_user.id } || Subscriber.new
  end

  def my_alerts
    @user = current_user
    @alerts = Alert.where(creator: @user)
    @notifications = Notification.where(recipient: @user)
    if @notifications.any?
      @time_ago = ((Time.new - @notifications.last.created_at) / 1.minute).round
    end
  end

  def new
    @alerts = Alert.all
    @alert = Alert.new
  end

  # def create
  #   @alert = Alert.create(alert_params)
  #   @alert.upvotes = 0
  #   @alert.status = 0
  #   @alert.creator_id = current_user.id
  #   if @alert.save
  #     redirect_to alert_path(@alert), notice: "Thank you for sending your alert."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def edit
  end

  def update
    if current_user == 'resident'
      if @alert.update(alert_params)
        redirect_to alert_path(@alert), notice: "Alert updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      @alert.update(alert_params)

      respond_to do |format|
        format.html { redirect_to alert_path(@alert), notice: "Alert updated successfully." }
        format.text { render partial: "shared/status_bar", locals: {alert: @alert}, formats: [:html] }
      end
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

  def analytics
    if current_user.role != "worker"
      flash[:alert] = "You are not authorized to view this page."
      redirect_to root_path
      flash[:alert]
    end
    @alerts = Alert.order(created_at: :desc)
  end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  end

  def alert_params
    params.require(:alert).permit(:title, :category, :address, :description, :upvotes, :status, photos: [])
  end
end
