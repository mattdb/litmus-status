module StatusUpdatesHelper
  def describe_status(up_or_down_bool)
    case up_or_down_bool
    when nil
      'unknown'
    when true
      'up'
    when false
      'down'
    end
  end


  def status_tag(up_or_down_bool)
    status_string = describe_status(up_or_down_bool)
    content_tag(:span, status_string, class: status_span_class(status_string))
  end

  def status_span_class(status_string)
    "status-#{status_string}"
  end

  def friendly_time_tag(timestamp)
    time_tag timestamp, "#{time_ago_in_words(timestamp)} ago"
  end

end
