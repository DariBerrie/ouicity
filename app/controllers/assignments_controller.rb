class AssignmentsController < ApplicationController
  def index
    @assignments = Assignment.all
  end

  def show
    @user = User.find(params[:id])
    @assignment = Assignment.where(user: @user)
    @alerts = @user.alerts
  end

  def new
    @assignment = Assignment.new
    @alert = Alert.find(params[:alert_id])
  end

  def create
    @assignment = Assignment.new
    @user = current_user
    @alert = Alert.find(params[:alert_id])
    @assignment.alert = @alert
    @assignment.user = @user
    if @assignment.save
      redirect_to alert_path(@alert), notice: "Alert has been successfully assigned."
    else
      render :new, status: :unprocessable_entity
    end
  end
end
