
class Reader

  def read(array)
    verb_pro_path = array[0].split
    host_port = array[1].split(":")
    # parameter = array.split("?")[1]

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
    # if path_name.include?("?")
      path_name.split("?")[0]
    # end
  end

  def parameters(array)
    verb_pro_path = array[0].split
    path_name = verb_pro_path[1].to_s
    parm = path_name.split("?")[1]
    parm.split("&")
  end

  def values(array)
    parm = parameters(array)
    value = parm.map do |word|
      word.split("=")[1]
    end
  end


end
