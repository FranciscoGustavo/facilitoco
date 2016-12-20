class NotificationsController < ApplicationController
	before_action :set_notification, only: [:update]

  def index
  	@notifications = Notification.where(user:current_user).unviewed.lastest
  	respond_to do |format|
  		format.html
  		format.js
  	end
  end

  def update
  	message = if @notification.update(notification_params)
  		"Notificación vista"
  	else
  		"Hubo un error"
  	end

  	redirect_to :back, notice: message
  end

  private

  def set_notification
  	@notification = Notification.find(params[:id])
  end

  def notification_params
  	params.require(:notification).permit(:viewed)
  end

end
