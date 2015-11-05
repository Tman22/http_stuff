require 'minitest/autorun'
require './lib/word_validation'
require './lib/reader'

class WordValidationTest < Minitest::Test

  def test_dictionary_validates_true_word
    array = ["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)
    words = Word_validation.new(reader.values)
    assert_equal [true], words.dictionary
  end

  def test_dictionary_returns_false_and_true
    array =["sky", "alsd", "word"]
    words = Word_validation.new(array)
    words.dictionary
    assert_equal [true, false, true], words.dictionary
  end

  def test_word_zips_with_dictionary_method
    array =["sky", "alsd", "word"]
    words = Word_validation.new(array)
    assert_equal [["sky", true], ["alsd", false], ["word", true]], words.word_with_array
  end

  def test_word_exists
    array =["GET /word_search?word=sky HTTP/1.1"]
    reader = Reader.new(array)
    words = Word_validation.new(reader.values)
    words.word_exist
    assert_equal ["sky is a known word"], words.word_exist
  end

  def test_multiple_words_exist
    array =["GET /word_search?word=sky&word=word&word=asdf HTTP/1.1"]
    reader = Reader.new(array)
    words = Word_validation.new(reader.values)
    assert_equal ["sky is a known word", "word is a known word", "asdf is not a known word"], words.word_exist
  end

  def test_word_output
    array =["GET /word_search?word=sky&word=asdf HTTP/1.1"]
    reader = Reader.new(array)
    words = Word_validation.new(reader.values)
    assert_equal "sky is a known word\n" "asdf is not a known word\n", words.word_output
  end
end
