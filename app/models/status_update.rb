class StatusUpdate < ApplicationRecord
  validate :require_either_status_or_message

  scope :with_status,  -> { where.not(is_up: nil) }
  scope :with_message, -> { where.not(message: nil) }
  scope :recent_first, -> { order(created_at: :desc) }

  def self.currently_up?
    current_update = with_status.recent_first.first
    current_update.try(:is_up)
  end

  def self.recent_messages(limit: 10)
    with_message.recent_first.limit(limit)
  end

protected
  def require_either_status_or_message
    if message.blank? && is_up.nil? then
      errors.add(:base, 'Must specify either a status or a message')
    end
  end
end
