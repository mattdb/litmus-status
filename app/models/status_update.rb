class StatusUpdate < ApplicationRecord
  validate :require_either_status_or_message

  def require_either_status_or_message

    if message.blank? && is_up.nil? then
      errors.add(:base, 'Must specify either a status or a message')
    end
  end
end
