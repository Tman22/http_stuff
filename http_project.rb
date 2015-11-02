require 'socket'
tcp_server = TCPServer.new(9292)
request_count = 0

loop do
  client = tcp_server.accept
  request_count += 1

  puts "Ready for a request"
  request_lines = []
  while line = client.gets and !line.chomp.empty?
    request_lines << line.chomp
  end

  verb_pro_path = request_lines[0].split
  host_port = request_lines[1].split(":")

  info = "<pre> Verb: #{verb_pro_path[0]}\r
  Path: #{verb_pro_path[1]}\r
  Protocal: #{verb_pro_path[2]}\r
  Host:#{host_port[1]}\r
  Port: #{host_port[2]}\r</pre>"

  puts "Got this request: #{request_lines.count})"

  puts "Sending response."
  response = "<pre> Hello world (#{request_count})\r\n #{info}\r\n #{request_lines.inspect} </pre>"
  # response = "<pre>" + request_lines.join("\n") + "</pre>"
  # output = "<html><head></head><body>#{request_count}\r\n #{response}\r\n #{request_lines.inspect}</body></html>"
  output = "<html><head></head><body>#{response}</body></html>"

  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")

  client.puts headers
  client.puts output
  #
  # puts ["Wrote this response:", headers, output].join("\n")
  # puts "\nResponse complete, exiting."
end
client.close
