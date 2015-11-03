require 'pry'

class Reader

  def read(array)
    verb_pro_path = array[0].split
    host_port = array[1].split(":")
    "<pre>    Verb: #{verb_pro_path[0]}\r
    Path: #{verb_pro_path[1]}\r
    Protocal: #{verb_pro_path[2]}\r
    Host:#{host_port[1]}\r
    Port: #{host_port[2]}\r
    Origin:#{host_port[1]}\r
    #{array[4]}
    </pre>"
  end

  def path(array)
    verb_pro_path = array[0].split
    path_name = verb_pro_path[1].to_s
      path_name.split("?")[0]
  end

  def parameters(array)
    verb_pro_path = array[0].split
    path_name = verb_pro_path[1].to_s
    parm = path_name.split("?")[1]
    parm.split("&")
  end

  def values(array)
    new_array = parameters(array)
    value = new_array.map do |word|
      word.split("=")[1]
    end
  end

  def dictionary(array)
    dict = File.read("/usr/share/dict/words")
    values(array).map do |word|
      dict.include?(word)
    end
  end

  def word_with_array(array)
    values(array).zip(dictionary(array))
  end

  def word_exist(array)
    word_with_array(array).map do |word|
      if word[1] == true
        "#{word[0]} is a known word"
      else
        "#{word[0]} is not a known word"
      end
    end
  end

end
