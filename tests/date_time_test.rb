require 'minitest/autorun'
require 'minitest/pride'
require './lib/date_time'

class DateTimeTest < Minitest::Test

  def test_date_is_in_correct_format
    date = Date_time.new.date_format
    assert_equal 6, date.split.count
  end
end
