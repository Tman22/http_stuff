require 'minitest/autorun'  # => true
require 'minitest/pride'    # => true
require_relative 'reader'   # => true

class Reader_test < Minitest::Test  # => Minitest::Test

  def test_reads_array
    array = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292",                                                                                               # => "Host: 127.0.0.1:9292"
            "Connection: keep-alive",                                                                                                                # => "Connection: keep-alive"
            "Cache-Control: max-age=0",                                                                                                              # => "Cache-Control: max-age=0"
            "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",                                                    # => "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
            "Upgrade-Insecure-Requests: 1",                                                                                                          # => "Upgrade-Insecure-Requests: 1"
            "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",  # => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36"
            "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]                                                               # => ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    reader = Reader.new(array)                                                                                                                       # => #<Reader:0x007fa9a30951b0 @request_lines=["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]>
    reader.read                                                                                                                                      # => "<pre>    Verb: GET\r\n    Path: /\r\n    Protocal: HTTP/1.1\r\n    Host: 127.0.0.1\r\n    Port: 9292\r\n    Origin: 127.0.0.1\r\n    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n    </pre>"
    # assert_equal
  end                                                                                                                                                # => :test_reads_array

  def test_path_returns_path
    array = ["GET /word_search?word=sky HTTP/1.1"]  # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                      # => #<Reader:0x007fa9a309cc08 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    reader.path                                     # => "/word_search"
    assert_equal "/word_search", reader.path        # => true
  end                                               # => :test_path_returns_path

  def test_parameters_returns_parameters
    array = ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)
    reader.parameters
    assert_equal ["word=sky"], reader.parameters
  end                                                    # => :test_parameters_returns_parameters

  def test_parameters_splits_two_parmeters
    array = ["GET /word_search?word=sky&word=woot HTTP/1.1"]
    reader = Reader.new(array)
    assert_equal ["word=sky","word=woot"], reader.parameters
  end
end  # => :test_path_returns_path

# >> Run options: --seed 48072
# >>
# >> # Running:
# >>
# >> ..
# >>
# >> Finished in 0.001143s, 1749.6160 runs/s, 874.8080 assertions/s.
# >>
# >> 2 runs, 1 assertions, 0 failures, 0 errors, 0 skips
