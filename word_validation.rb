class Word_validation
  attr_reader :parameters
  def initialize(parameters)
    @parameters = parameters

  end

  def values
    new_array = parameters
    value = new_array.map do |word|
      word.split("=")[1]
    end
  end

  def dictionary
    dict = File.read("/usr/share/dict/words")
    values.map do |word|
      dict.include?(word)
    end
  end

  def word_with_array
    values.zip(dictionary)
  end

  def word_exist
    new_array = word_with_array.map do |word|
      if word[1] == true
        "#{word[0]} is a known word"
      else
        "#{word[0]} is not a known word"
      end
    end
  end

end
