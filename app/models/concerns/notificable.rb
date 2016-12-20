module Notificable
	extend ActiveSupport::Concern

	included do
		
		has_many :notifications, as: :item
		after_create :send_notificable_to_users
	end

	def send_notificable_to_users
		if self.respond_to? :user_ids
			NotificationSenderJob.perform_later(self)
		end
	end
end