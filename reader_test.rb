require 'minitest/autorun'  # => true
require 'minitest/pride'    # => true
require_relative 'reader'   # => true

class Reader_test < Minitest::Test  # => Minitest::Test

  def test_reads_array
    reader = Reader.new                                                                                                                                                                                                                                                                                                                                                                                                                                # => #<Reader:0x007fe58aa616a8>
    array = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]  # => ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    reader.read(array)                                                                                                                                                                                                                                                                                                                                                                                                                                 # => "<pre>    Verb: GET\r\n    Path: /\r\n    Protocal: HTTP/1.1\r\n    Host: 127.0.0.1\r\n    Port: 9292\r\n    Origin: 127.0.0.1\r\n    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n    </pre>"
    # assert_equal
  end                                                                                                                                                                                                                                                                                                                                                                                                                                                  # => :test_reads_array

  def test_path_returns_path
    reader = Reader.new                              # => #<Reader:0x007fe58988f5d8>
    array = ["GET /word_search?word=sky HTTP/1.1"]   # => ["GET /word_search?word=sky HTTP/1.1"]
    assert_equal "/word_search", reader.path(array)  # => true
  end                                                # => :test_path_returns_path

  def test_parameters_returns_parameters
    reader = Reader.new                                  # => #<Reader:0x007fe58aa60b40>
    array = ["GET /word_search?word=sky HTTP/1.1"]       # => ["GET /word_search?word=sky HTTP/1.1"]
    reader.parameters(array)                             # => ["word=sky"]
    assert_equal ["word=sky"], reader.parameters(array)  # => true
  end                                                    # => :test_parameters_returns_parameters

  def test_parameters_splits_two_parmeters
    reader = Reader.new                                              # => #<Reader:0x007fe58988ca40>
    array = ["GET /word_search?word=sky&word=woot HTTP/1.1"]         # => ["GET /word_search?word=sky&word=woot HTTP/1.1"]
    assert_equal ["word=sky","word=woot"], reader.parameters(array)  # => true
  end                                                                # => :test_parameters_splits_two_parmeters

  def test_parameter_values
    reader = Reader.new                                               # => #<Reader:0x007fe58aa6b798>
    array = ["GET /word_search?word=sky&word=woot HTTP/1.1"]          # => ["GET /word_search?word=sky&word=woot HTTP/1.1"]
    assert_equal ["word=sky", "word=woot"], reader.parameters(array)  # => true
    assert_equal ["sky", "woot"], reader.values(array)

  end  # => :test_parameter_values

end  # => :test_parameter_values

# >> Run options: --seed 3694
# >>
# >> # Running:
# >>
# >> ....E
# >>
# >> Finished in 0.001527s, 3275.2736 runs/s, 2620.2189 assertions/s.
# >>
# >>   1) Error:
# >> Reader_test#test_parameter_values:
# >> NoMethodError: undefined method `assert_eqaul' for #<Reader_test:0x007fe58aa6b900>
# >>     /Users/taylormoore/turing/1module/http_stuff/reader_test.rb:37:in `test_parameter_values'
# >>
# >> 5 runs, 4 assertions, 0 failures, 1 errors, 0 skips
