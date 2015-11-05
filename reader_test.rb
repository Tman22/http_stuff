require 'minitest/autorun'
require 'minitest/pride'
require_relative 'reader'

class Reader_test < Minitest::Test

  def test_reads_array
    array = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292",
            "Connection: keep-alive",
            "Cache-Control: max-age=0",
            "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
            "Upgrade-Insecure-Requests: 1",
            "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
            "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    reader = Reader.new(array)
    reader.read
    # assert_equal
  end

  def test_path_returns_path
    array = ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)
    reader.path
    assert_equal "/word_search", reader.path
  end

  def test_parameters_returns_parameters
    array = ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)
    reader.parameters
    assert_equal ["word=sky"], reader.parameters
  end

  def test_parameters_splits_two_parmeters
    array = ["GET /word_search?word=sky&word=woot HTTP/1.1"]
    reader = Reader.new(array)
    assert_equal ["word=sky","word=woot"], reader.parameters
  end

  def test_parameter_values
    array = ["GET /word_search?word=sky&word=sadf HTTP/1.1"]
    reader = Reader.new(array)
    words = Word_validation.new(reader.values)
    word.values
    assert_equal ["sky", "sadf"], words.values
  end

end
