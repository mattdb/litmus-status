class StatusUpdatesController < ApplicationController

  def index
    @current_status = StatusUpdate.currently_up?
    @message_history = StatusUpdate.recent_messages
  end
end
