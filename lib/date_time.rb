class Date_time

  def date_format
    Time.new.strftime('%l:%M%p on %A, %B %-d %Y')
  end

end
