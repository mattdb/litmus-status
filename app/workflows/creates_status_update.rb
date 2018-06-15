class CreatesStatusUpdate
  attr_accessor :status, :message, :update, :success, :error

  def initialize(status: "", message: "")
    @status = status
    @message = message
    @success = false
  end

  def success?
    @success
  end

  def build
    parse_status
      .map {|is_up| StatusUpdate.new(is_up: is_up, message: message) }

  end

  def create
    build
      .and_then { |update| save_update(update) }
      .on_success do |update|
        self.error = nil
        self.success = true
      end
      .on_failure do |error|
        self.error = error
        self.success = false
      end
  end

  # The following method is the reason I pulled in the Resonad gem --
  # really we need to handle 4 possible states, even though the column is just a boolean:
  # 1) No status specified
  # 2) Status: UP
  # 3) Status: DOWN
  # 4) None of the above (i.e. something invalid specified for status)
  # And we need to not continue to create StatusUpdate record if we find ourselves in #4.
  # The perfect situation for a Result Monad!
  def parse_status
    if status.blank?
      Resonad.Success(nil)
    elsif status.upcase == "UP"
      Resonad.Success(true)
    elsif status.upcase == "DOWN"
      Resonad.Success(false)
    else
      Resonad.Failure("Invalid Status: #{status}")
    end
  end

private
  def save_update(update)
    self.update = update
    if update.save
      Resonad.Success(update)
    else
      Resonad.Failure(update.errors.full_messages.join(', '))
    end
  end

end
