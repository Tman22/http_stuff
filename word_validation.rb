class Word_validation
  attr_reader :values     # => nil
  def initialize(values)
    @values = values
  end                         # => :initialize
  #
  # def values
  #   new_array = parameters
  #   value = new_array.map do |word|
  #     word.split("=")[1]
  #   end
  # end

  def dictionary
    dict = File.read("/usr/share/dict/words")
    values.map do |word|
      dict.include?(word)
    end
  end                                          # => :dictionary

  def word_with_array
    @values.zip(dictionary)
  end                       # => :word_with_array

  def word_exist
    new_array = word_with_array.map do |word|
      if word[1] == true
        "#{word[0]} is a known word"
      else
        "#{word[0]} is not a known word"
      end
    end
  end                                          # => :word_exist

  def word_output
    words_result = word_exist
    end_result = ""
    words_result.each do |word|
      end_result << "#{word}\n"
    end
    end_result
  end                            # => :word_output
end                              # => :word_output
