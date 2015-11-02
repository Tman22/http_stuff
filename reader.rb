
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
    "#{verb_pro_path[1]}"
  end   # => :read


end  # => :read
