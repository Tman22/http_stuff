require 'minitest/autorun'  # => true
require 'minitest/pride'    # => true
require './lib/parsers'  # => true

class ParsersTest < Minitest::Test  # => Minitest::Test

  def test_home_returns_value
    request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]  # => ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]
    parser = Parsers.new(request_lines)                         # => #<Parsers:0x007ff1d983d330 @reader=#<Reader:0x007ff1d983d2e0 @request_lines=["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]>, @date=" 8:13AM on Thursday, November 5 2015", @path="/">
    assert_equal "<pre></pre>", parser.home                     # => true
  end                                                           # => :test_home_returns_value

  def test_hello_counts
    request_count = 0                                                        # => 0
    request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]               # => ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]
    parser = Parsers.new(request_lines)                                      # => #<Parsers:0x007ff1d984f6e8 @reader=#<Reader:0x007ff1d984f6c0 @request_lines=["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]>, @date=" 8:13AM on Thursday, November 5 2015", @path="/">
    request_count += 1                                                       # => 1
    request_count += 1                                                       # => 2
    assert_equal "<pre> Hello world (2)</pre>", parser.hello(request_count)  # => true
  end                                                                        # => :test_hello_counts

  def test_date_time_returns
    request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]                                    # => ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]
    parser = Parsers.new(request_lines)                                                           # => #<Parsers:0x007ff1d984cc40 @reader=#<Reader:0x007ff1d984cb78 @request_lines=["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]>, @date=" 8:13AM on Thursday, November 5 2015", @path="/">
    assert_equal "<pre>#{Time.new.strftime('%l:%M%p on %A, %B %-d %Y')}</pre>", parser.date_time  # => true
  end                                                                                             # => :test_returns_date_time

  def test_word_validation_returns_words
    request_lines = ["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]                                           # => ["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]
    parser = Parsers.new(request_lines)                                                                                  # => #<Parsers:0x007ff1d9857398 @reader=#<Reader:0x007ff1d9857320 @request_lines=["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]>, @date=" 8:13AM on Thursday, November 5 2015", @path="/word_search">
    assert_equal "<pre>sky is a known word\nword is a known word\nasdf is not a known word\n</pre>", parser.word_search  # => true
  end                                                                                                                    # => :test_word_validation_returns_words

  def test_shutdown_uses_count
    request_count = 0                                                              # => 0
    request_lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]                     # => ["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]
    parser = Parsers.new(request_lines)                                            # => #<Parsers:0x007ff1d983fc70 @reader=#<Reader:0x007ff1d983fc20 @request_lines=["GET / HTTP/1.1", "Host: 127.0.0.1:9292"]>, @date=" 8:13AM on Thursday, November 5 2015", @path="/">
    request_count += 1                                                             # => 1
    request_count += 1                                                             # => 2
    assert_equal "<pre> Total requests: 2 </pre>", parser.shutdown(request_count)  # => true
  end                                                                              # => :test_shutdown_uses_count



end  # => :test_shutdown_uses_count

# >> Run options: --seed 12181
# >>
# >> # Running:
# >>
# >> .....
# >>
# >> Finished in 0.007704s, 649.0123 runs/s, 649.0123 assertions/s.
# >>
# >> 5 runs, 5 assertions, 0 failures, 0 errors, 0 skips
