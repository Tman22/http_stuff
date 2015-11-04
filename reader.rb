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

  def split_request
    verb_pro_path = @request_lines[0].split
    verb_pro_path[1].to_s
  end

  def path
    path_name = split_request
    path_name.split("?")[0]
  end

  def parameters
    path_name = split_request
    parameters = path_name.split("?")[1]
    parameters.split("&")
  end
end
