require 'minitest/autorun'          # => true
require_relative 'word_validation'  # => true
require_relative 'reader'           # => true

class WordValidationTest < Minitest::Test  # => Minitest::Test

  def test_parameters_exist
    array = ["GET /word_search?word=sky HTTP/1.1"]  # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                      # => #<Reader:0x007fa57c16c460 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)  # => #<Word_validation:0x007fa57c16cde8 @parameters=["word=sky"]>
    assert_equal ["sky"], words.values              # => true
  end                                               # => :test_parameters_exist

  def test_parameter_values
    array = ["GET /word_search?word=sky&word=sadf HTTP/1.1"]  # => ["GET /word_search?word=sky&word=sadf HTTP/1.1"]
    reader = Reader.new(array)                                # => #<Reader:0x007fa57c07c2a8 @request_lines=["GET /word_search?word=sky&word=sadf HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)            # => #<Word_validation:0x007fa57c07ceb0 @parameters=["word=sky", "word=sadf"]>
    assert_equal ["sky", "sadf"], words.values                # => true
  end                                                         # => :test_parameter_values

  def test_dictionary_validates_true_word
    array = ["GET /word_search?word=sky HTTP/1.1"]  # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                      # => #<Reader:0x007fa57c06e5e0 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)  # => #<Word_validation:0x007fa57c06d488 @parameters=["word=sky"]>
    assert_equal [true], words.dictionary           # => true
  end                                               # => :test_dictionary_validates_true_word

  def test_dictionary_returns_false_and_true
    array =["word=sky", "word=alsd", "word=word"]       # => ["word=sky", "word=alsd", "word=word"]
    words = Word_validation.new(array)                  # => #<Word_validation:0x007fa57c16e080 @parameters=["word=sky", "word=alsd", "word=word"]>
    words.dictionary                                    # => [true, false, true]
    assert_equal [true, false, true], words.dictionary  # => true
  end                                                   # => :test_dictionary_returns_false_and_true

  def test_word_zips_with_dictionary_method
    array =["word=sky", "word=alsd", "word=word"]                                         # => ["word=sky", "word=alsd", "word=word"]
    words = Word_validation.new(array)                                                    # => #<Word_validation:0x007fa57c074f08 @parameters=["word=sky", "word=alsd", "word=word"]>
    assert_equal [["sky", true], ["alsd", false], ["word", true]], words.word_with_array  # => true
  end                                                                                     # => :test_word_zips_with_dictionary_method

  def test_word_exists
    array =["GET /word_search?word=sky HTTP/1.1"]           # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                              # => #<Reader:0x007fa57c077370 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)          # => #<Word_validation:0x007fa57c076c90 @parameters=["word=sky"]>
    words.word_exist                                        # => ["sky is a known word"]
    assert_equal ["sky is a known word"], words.word_exist  # => true
  end                                                       # => :test_word_exists

  def test_multiple_words_exist
    array =["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]                                           # => ["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]
    reader = Reader.new(array)                                                                                  # => #<Reader:0x007fa57c05e370 @request_lines=["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)                                                              # => #<Word_validation:0x007fa57c05ddf8 @parameters=["word=sky", "word=word", "word=asdf"]>
    assert_equal ["sky is a known word", "word is a known word", "asdf is not a known word"], words.word_exist  # => true
  end                                                                                                           # => :test_multiple_words_exist

  def test_word_output
    array =["GET /word_search?word=sky&word=asdf HTTP/1.1"]                             # => ["GET /word_search?word=sky&word=asdf HTTP/1.1"]
    reader = Reader.new(array)                                                          # => #<Reader:0x007fa57c06f350 @request_lines=["GET /word_search?word=sky&word=asdf HTTP/1.1"]>
    words = Word_validation.new(reader.parameters)                                      # => #<Word_validation:0x007fa57c067588 @parameters=["word=sky", "word=asdf"]>
    assert_equal "sky is a known word\n" "asdf is not a known word\n", words.word_output
  end                                                                                   # => :test_word_output
end                                                                                     # => :test_word_output

# >> Run options: --seed 20220
# >>
# >> # Running:
# >>
# >> ....F...
# >>
# >> Finished in 0.061705s, 129.6501 runs/s, 129.6501 assertions/s.
# >>
# >>   1) Failure:
# >> WordValidationTest#test_word_output [/Users/taylormoore/turing/1module/http_stuff/word_validation_test.rb:60]:
# >> --- expected
# >> +++ actual
# >> @@ -1,2 +1,3 @@
# >> -"sky is a known word
# >> -asdf is not a known word"
# >> +"sky is a known word
# >> +asdf is not a known word
# >> +"
# >>
# >>
# >> 8 runs, 8 assertions, 1 failures, 0 errors, 0 skips
