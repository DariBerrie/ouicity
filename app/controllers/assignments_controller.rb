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
    @alert = Alert.find(params[:alert_id])
    @worker = User.find(params.require(:assignment)[:worker_id])
    @assignment.alert = @alert
    @assignment.worker = @worker
    if @assignment.save
      redirect_to alert_path(@alert), notice: "Alert has been successfully assigned."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def my_assignments
    @user = current_user
    @assignments = Assignment.where(worker: @user)
  end
end
