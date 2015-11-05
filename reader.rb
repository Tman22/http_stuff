require 'pry'

class Reader

  def initialize(request_lines)
    @request_lines = request_lines

  end

  def read
    verb_pro_path = @request_lines[0].split
    host_port = @request_lines[1].split(":")
    "<pre>    Verb: #{verb_pro_path[0]}\r
    Path: #{verb_pro_path[1]}\r
    Protocal: #{verb_pro_path[2]}\r
    Host:#{host_port[1]}\r
    Port: #{host_port[2]}\r
    Origin:#{host_port[1]}\r
    #{@request_lines[4]}
    </pre>"
  end

  def find_verb
    verb_pro_path = @request_lines[0].split
    verb_pro_path[0].to_s
    #make test
  end

  def split_path_and_params
    verb_pro_path = @request_lines[0].split
    verb_pro_path[1].to_s
  end

  def path
    path_name = split_path_and_params
    path_name.split("?")[0]
  end

  def parameters
    path_name = split_path_and_params
    parameters = path_name.split("?")[1]
    parameters.split("&")
  end

  def values #rewrite tests
    new_array = parameters
    value = new_array.map do |word|
      word.split("=")[1]
    end
  end

end
