class CB2::Percentage < CB2::RollingWindow
  # keep a rolling window of all calls too
  def count
    @current_count = increment_rolling_window(key("count"))
  end

  private

  def should_open?(error_count)
    # do not open until we have a reasonable number of requests
    return false if self.count < 5

    error_perc = error_count * 100 / self.count.to_f
    return error_perc >= threshold
  end
end
