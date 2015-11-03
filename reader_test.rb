require 'minitest/autorun'  # => true
require 'minitest/pride'    # => true
require_relative 'reader'   # => true

class Reader_test < Minitest::Test  # => Minitest::Test

  def test_reads_array
    reader = Reader.new                                                                                                                                                                                                                                                                                                                                                                                                                                # => #<Reader:0x007fe48311eaa8>
    array = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]  # => ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive", "Cache-Control: max-age=0", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    reader.read(array)                                                                                                                                                                                                                                                                                                                                                                                                                                 # => "<pre>    Verb: GET\r\n    Path: /\r\n    Protocal: HTTP/1.1\r\n    Host: 127.0.0.1\r\n    Port: 9292\r\n    Origin: 127.0.0.1\r\n    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n    </pre>"
    # assert_equal
  end                                                                                                                                                                                                                                                                                                                                                                                                                                                  # => :test_reads_array

  def test_path_returns_path
    reader = Reader.new                              # => #<Reader:0x007fe48311df68>
    array = ["GET /word_search?word=sky HTTP/1.1"]   # => ["GET /word_search?word=sky HTTP/1.1"]
    assert_equal "/word_search", reader.path(array)  # => true
  end                                                # => :test_path_returns_path

  def test_parameters_returns_parameters
    reader = Reader.new                                  # => #<Reader:0x007fe48311d630>
    array = ["GET /word_search?word=sky HTTP/1.1"]       # => ["GET /word_search?word=sky HTTP/1.1"]
    reader.parameters(array)                             # => ["word=sky"]
    assert_equal ["word=sky"], reader.parameters(array)  # => true
  end                                                    # => :test_parameters_returns_parameters

  def test_parameters_splits_two_parmeters
    reader = Reader.new                                              # => #<Reader:0x007fe48311c8e8>
    array = ["GET /word_search?word=sky&word=woot HTTP/1.1"]         # => ["GET /word_search?word=sky&word=woot HTTP/1.1"]
    assert_equal ["word=sky","word=woot"], reader.parameters(array)  # => true
  end                                                                # => :test_parameters_splits_two_parmeters

  def test_parameter_values
    reader = Reader.new                                              # => #<Reader:0x007fe48311f7f0>
    array = ["GET /word_search?word=sky&word=why HTTP/1.1"]          # => ["GET /word_search?word=sky&word=why HTTP/1.1"]
    assert_equal ["word=sky", "word=why"], reader.parameters(array)  # => true
    assert_equal ["sky", "why"], reader.values(array)                # => true
  end                                                                # => :test_parameter_values

  def test_dictionary_returns_array
    reader = Reader.new                                     # => #<Reader:0x007fe48207f6c0>
    array =["GET /word_search?word=sky&word=why HTTP/1.1"]  # => ["GET /word_search?word=sky&word=why HTTP/1.1"]
    reader.dictionary(array)                                # => [true, true]
    assert_equal [true, true], reader.dictionary(array)     # => true
  end                                                       # => :test_dictionary_returns_array

  def test_dictionary_returns_false_and_true
    reader = Reader.new                                                # => #<Reader:0x007fe482087000>
    array =["GET /word_search?word=sky&word=alsd&word=word HTTP/1.1"]  # => ["GET /word_search?word=sky&word=alsd&word=word HTTP/1.1"]
    reader.dictionary(array)                                           # => [true, false, true]
    assert_equal [true, false, true], reader.dictionary(array)         # => true
  end                                                                  # => :test_dictionary_returns_false_and_true

  def test_word_zips_with_dictionary_method
    reader = Reader.new                                                           # => #<Reader:0x007fe4830a9690>
    array =["GET /word_search?word=sky&word=dasd HTTP/1.1"]                       # => ["GET /word_search?word=sky&word=dasd HTTP/1.1"]
    reader.word_with_array(array)                                                 # => [["sky", true], ["dasd", false]]
    assert_equal [["sky", true], ["dasd", false]], reader.word_with_array(array)  # => true
  end

  # def test_word_exists
  #
  #
  # end
                                                                      # => :test_word_zips_with_dictionary_method

end  # => :test_word_zips_with_dictionary_method

# >> Run options: --seed 21850
# >>
# >> # Running:
# >>
# >> ........
# >>
# >> Finished in 0.028882s, 276.9913 runs/s, 276.9913 assertions/s.
# >>
# >> 8 runs, 8 assertions, 0 failures, 0 errors, 0 skips
