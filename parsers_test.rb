require 'minitest/autorun'
require 'minitest/pride'
require './lib/parsers'

class ParsersTest < Minitest::Test

  def test_home_returns_value
    request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]
    parser = Parsers.new(request_lines)
    assert_equal "<pre></pre>", parser.home
  end

  def test_hello_counts
    request_count = 0
    request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]
    parser = Parsers.new(request_lines)
    request_count += 1
    request_count += 1
    assert_equal "<pre> Hello world (2)</pre>", parser.hello(request_count)
  end

  def test_date_time_returns
    request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]
    parser = Parsers.new(request_lines)
    assert_equal "<pre>#{Time.new.strftime('%l:%M%p on %A, %B %-d %Y')}</pre>", parser.date_time
  end

  def test_word_validation_returns_words
    request_lines = ["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]
    parser = Parsers.new(request_lines)
    assert_equal "<pre>sky is a known word\nword is a known word\nasdf is not a known word\n</pre>", parser.word_search
  end

  def test_shutdown_uses_count
    request_count = 0
    request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]
    parser = Parsers.new(request_lines)
    request_count += 1
    request_count += 1
    assert_equal "<pre> Total requests: 2 </pre>", parser.shutdown(request_count)
  end



end
