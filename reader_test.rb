require 'minitest/autorun'
require 'minitest/pride'
require_relative 'reader'
require_relative 'word_validation'

class Reader_test < Minitest::Test

  def test_reader_exists
    reader = Reader.new(request_get)
    assert reader
  end

  def test_reads_array
    reader = Reader.new(request_get)
    assert_equal '<pre>    Verb: GET\r
    Path: /\r
    Protocal: HTTP/1.1\r
    Host: 127.0.0.1\r
    Port: 9292\r
    Origin: 127.0.0.1\r
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\r
    </pre>', reader.read
    # also tried double quotes but then it interprets the \r and removes it
  end

  def test_split_path_and_params_works_with_no_parameters
    reader = Reader.new(request_post)
    assert_equal '/start_game', reader.split_path_and_params
  end

  def test_split_path_and_params_works_with_parameters
    reader = Reader.new(request_word_search)
    assert_equal '/word_search?word=sky&word=asdf&word=word', reader.split_path_and_params
  end

  def test_path_with_POST_request
    reader = Reader.new(request_post)
    assert_equal "/start_game", reader.path
  end

  def test_path_with_GET_request
    reader = Reader.new(request_get)
    assert_equal "/", reader.path
  end

  def test_find_verb_GET
    reader = Reader.new(request_word_search)
    assert "GET", reader.find_verb
  end

  def test_find_verb_POST
    reader = Reader.new(request_post)
    assert "POST", reader.find_verb
  end

  def test_parameters_returns_a_parameter
    array = ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)
    reader.parameters
    assert_equal ["word=sky"], reader.parameters
  end

  def test_parameters_splits_up_multiple_parameters
    reader = Reader.new(request_word_search)
    assert_equal ["word=sky","word=asdf", "word=word"], reader.parameters
  end

  def test_values
    reader = Reader.new(request_word_search)
    words = Word_validation.new(reader.values)
    assert_equal ["sky", "asdf", "word"], words.values
  end


  def request_get
    @request_lines = ["GET / HTTP/1.1",
                      "Host: 127.0.0.1:9292",
                      "Connection: keep-alive",
                      "Cache-Control: max-age=0",
                      "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                      "Upgrade-Insecure-Requests: 1",
                      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                      "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"]
    @request_lines
  end

  def request_post
    @request_lines = ["POST /start_game HTTP/1.1",
                      "Host: 127.0.0.1:9292",
                      "Connection: keep-alive",
                      "Content-Length: 137",
                      "Cache-Control: no-cache",
                      "Origin: chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
                      "Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryJPA3j5ntOhqtuJ2X",
                      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                      "Postman-Token: c5f27b6c-c6dd-02ea-7342-932991534c26",
                      "Accept: */*",
                      "Accept-Encoding: gzip, deflate",
                      "Accept-Language: en-US,en;q=0.8"]
  end

  def request_word_search
    @request_lines = ["GET /word_search?word=sky&word=asdf&word=word HTTP/1.1",
                      "Host: 127.0.0.1:9292",
                      "Connection: keep-alive",
                      "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                      "Upgrade-Insecure-Requests: 1",
                      "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                      "Accept-Encoding: gzip, deflate, sdch",
                      "Accept-Language: en-US,en;q=0.8"]
    @request_lines
  end

end
