module TaskHelper
  def task_priority_to_s(priority)
    if priority == 3
      return "high"
    elsif priority == 2
      return "average"
    elsif priority == 1
      return "low"
    else
      return "unknown"
    end
  end

  def task_status_to_s(status)
    if status == 2
      return "complete"
    elsif status == 1
      return "in-progress"
    else
      return "unknown"
    end
  end
end
