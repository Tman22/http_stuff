require 'minitest/autorun'          # => true
require_relative 'word_validation'  # => true
require_relative 'reader'           # => true

class WordValidationTest < Minitest::Test  # => Minitest::Test

  def test_parameters_exist
    array = ["GET /word_search?word=sky HTTP/1.1"]  # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                      # => #<Reader:0x007fb15c2e5af8 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)  # => #<Word_validation:0x007fb15c2e53a0 @parameters=["word=sky"]>
    assert_equal ["sky"], words.values              # => true
  end                                               # => :test_parameters_exist

  def test_parameter_values
    array = ["GET /word_search?word=sky&word=sadf HTTP/1.1"]  # => ["GET /word_search?word=sky&word=sadf HTTP/1.1"]
    reader = Reader.new(array)                                # => #<Reader:0x007fb15d18dd30 @request_lines=["GET /word_search?word=sky&word=sadf HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)            # => #<Word_validation:0x007fb15d18d830 @parameters=["word=sky", "word=sadf"]>
    assert_equal ["sky", "sadf"], words.values                # => true
  end                                                         # => :test_parameter_values

  def test_dictionary_validates_true_word
    array = ["GET /word_search?word=sky HTTP/1.1"]  # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                      # => #<Reader:0x007fb15d18f630 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)  # => #<Word_validation:0x007fb15d18ec58 @parameters=["word=sky"]>
    assert_equal [true], words.dictionary           # => true
  end                                               # => :test_dictionary_validates_true_word

  def test_dictionary_returns_false_and_true
    array =["word=sky", "word=alsd", "word=word"]       # => ["word=sky", "word=alsd", "word=word"]
    words = Word_validation.new(array)                  # => #<Word_validation:0x007fb15d18ca70 @parameters=["word=sky", "word=alsd", "word=word"]>
    words.dictionary                                    # => [true, false, true]
    assert_equal [true, false, true], words.dictionary  # => true
  end                                                   # => :test_dictionary_returns_false_and_true

  def test_word_zips_with_dictionary_method
    array =["word=sky", "word=alsd", "word=word"]                                         # => ["word=sky", "word=alsd", "word=word"]
    words = Word_validation.new(array)                                                    # => #<Word_validation:0x007fb15c2e4298 @parameters=["word=sky", "word=alsd", "word=word"]>
    assert_equal [["sky", true], ["alsd", false], ["word", true]], words.word_with_array  # => true
  end                                                                                     # => :test_word_zips_with_dictionary_method

  def test_word_exists
    array =["GET /word_search?word=sky HTTP/1.1"]           # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                              # => #<Reader:0x007fb15c1a4ce8 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)          # => #<Word_validation:0x007fb15c1a4680 @parameters=["word=sky"]>
    words.word_exist                                        # => ["sky is a known word"]
    assert_equal ["sky is a known word"], words.word_exist  # => true
  end                                                       # => :test_word_exists

  def test_multiple_words_exist
    array =["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]                                           # => ["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]
    reader = Reader.new(array)                                                                                  # => #<Reader:0x007fb15d196980 @request_lines=["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)                                                              # => #<Word_validation:0x007fb15d196250 @parameters=["word=sky", "word=word", "word=asdf"]>
    words.word_exist                                                                                            # => ["sky is a known word", "word is a known word", "asdf is not a known word"]
    assert_equal ["sky is a known word", "word is a known word", "asdf is not a known word"], words.word_exist  # => true
  end                                                                                                           # => :test_multiple_words_exist

end  # => :test_multiple_words_exist

# >> Run options: --seed 17969
# >>
# >> # Running:
# >>
# >> .......
# >>
# >> Finished in 0.052660s, 132.9291 runs/s, 132.9291 assertions/s.
# >>
# >> 7 runs, 7 assertions, 0 failures, 0 errors, 0 skips
