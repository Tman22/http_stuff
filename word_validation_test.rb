require 'minitest/autorun'          # => true
require_relative 'word_validation'  # => true
require_relative 'reader'           # => true

class WordValidationTest < Minitest::Test  # => Minitest::Test

  # def test_parameters_exist
  #   array = ["GET /word_search?word=sky HTTP/1.1"]  # => ["GET /word_search?word=sky HTTP/1.1"]
  #   reader = Reader.new(array)                      # => #<Reader:0x007f9d59a80bf8 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
  #   words = Word_validation.new(reader.values)      # => #<Word_validation:0x007f9d59a80270 @values=["sky"]>
  #   assert_equal ["sky"], words.values              # => true
  # end                                               # => :test_parameters_exist
  #
  # def test_parameter_values
  #   array = ["GET /word_search?word=sky&word=sadf HTTP/1.1"]  # => ["GET /word_search?word=sky&word=sadf HTTP/1.1"]
  #   reader = Reader.new(array)                                # => #<Reader:0x007f9d59a72008 @request_lines=["GET /word_search?word=sky&word=sadf HTTP/1.1"]>
  #   words = Word_validation.new(reader.values)                # => #<Word_validation:0x007f9d59a719a0 @values=["sky", "sadf"]>
  #   word.values
  #   assert_equal ["sky", "sadf"], words.values
  # end                                                         # => :test_parameter_values

  def test_dictionary_validates_true_word
    array = ["GET /word_search?word=sky HTTP/1.1"]  # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                      # => #<Reader:0x007fadec80d8f0 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    words = Word_validation.new(reader.values)      # => #<Word_validation:0x007fadec80f1f0 @values=["sky"]>
    assert_equal [true], words.dictionary           # => true
  end                                               # => :test_dictionary_validates_true_word

  def test_dictionary_returns_false_and_true
    array =["sky", "alsd", "word"]                      # => ["sky", "alsd", "word"]
    words = Word_validation.new(array)                  # => #<Word_validation:0x007faded8eed68 @values=["sky", "alsd", "word"]>
    words.dictionary                                    # => [true, false, true]
    assert_equal [true, false, true], words.dictionary  # => true
  end                                                   # => :test_dictionary_returns_false_and_true

  def test_word_zips_with_dictionary_method
    array =["sky", "alsd", "word"]                                         # => ["word=sky", "word=alsd", "word=word"]
    words = Word_validation.new(array)                                                    # => #<Word_validation:0x007fadec816680 @values=["word=sky", "word=alsd", "word=word"]>
    assert_equal [["sky", true], ["alsd", false], ["word", true]], words.word_with_array
  end                                                                                     # => :test_word_zips_with_dictionary_method

  def test_word_exists
    array =["GET /word_search?word=sky HTTP/1.1"]           # => ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)                              # => #<Reader:0x007fadec80f330 @request_lines=["GET /word_search?word=sky HTTP/1.1"]>
    words = Word_validation.new(reader.values)              # => #<Word_validation:0x007fadec80ed40 @values=["sky"]>
    words.word_exist                                        # => ["sky is a known word"]
    assert_equal ["sky is a known word"], words.word_exist  # => true
  end                                                       # => :test_word_exists

  def test_multiple_words_exist
    array =["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]                                           # => ["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]
    reader = Reader.new(array)                                                                                  # => #<Reader:0x007fadec80d6e8 @request_lines=["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]>
    words = Word_validation.new(reader.values)                                                                  # => #<Word_validation:0x007fadec80ce28 @values=["sky", "word", "asdf"]>
    assert_equal ["sky is a known word", "word is a known word", "asdf is not a known word"], words.word_exist  # => true
  end                                                                                                           # => :test_multiple_words_exist

  def test_word_output
    array =["GET /word_search?word=sky&word=asdf HTTP/1.1"]                               # => ["GET /word_search?word=sky&word=asdf HTTP/1.1"]
    reader = Reader.new(array)                                                            # => #<Reader:0x007fadec354c00 @request_lines=["GET /word_search?word=sky&word=asdf HTTP/1.1"]>
    words = Word_validation.new(reader.values)                                            # => #<Word_validation:0x007fadec354138 @values=["sky", "asdf"]>
    assert_equal "sky is a known word\n" "asdf is not a known word\n", words.word_output  # => true
  end                                                                                     # => :test_word_output
end                                                                                       # => :test_word_output

# >> Run options: --seed 3943
# >>
# >> # Running:
# >>
# >> F.....
# >>
# >> Finished in 0.052194s, 114.9567 runs/s, 114.9567 assertions/s.
# >>
# >>   1) Failure:
# >> WordValidationTest#test_word_zips_with_dictionary_method [/Users/taylormoore/turing/1module/http_stuff/word_validation_test.rb:39]:
# >> --- expected
# >> +++ actual
# >> @@ -1 +1 @@
# >> -[["sky", true], ["alsd", false], ["word", true]]
# >> +[["word=sky", false], ["word=alsd", false], ["word=word", false]]
# >>
# >>
# >> 6 runs, 6 assertions, 1 failures, 0 errors, 0 skips
