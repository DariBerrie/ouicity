# To deliver this notification:
#
# StatusNotification.with(post: @post).deliver_later(current_user)
# StatusNotification.with(post: @post).deliver(current_user)

class StatusNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :action_cable
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :alert

  # Define helper methods to make rendering easier.
  #
  def message
    "Your alert status has been updated."
  end

  def url
    alert_path(params[:alert])
  end
end
