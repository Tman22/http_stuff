require 'socket'
require_relative 'reader'
# require 'minitest/autorun'
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

  reader = Reader.new
  info = reader.read(request_lines)
  # word_exist = reader.word_exist(request_lines)

  puts "Got this request: (#{request_count})"
  puts "Sending response."

  # unless reader.path(request_lines "/favicon.ico")
  if reader.path(request_lines) == "/"
    response = "<pre>#{info}\n #{request_lines.inspect}</pre>"

  elsif reader.path(request_lines) == "/hello"
    response = "<pre> Hello world (#{request_count})\r\n #{info}\r\n </pre>"
  elsif reader.path(request_lines) == "/datetime"
    response = "<pre>#{Time.new.strftime('%l:%M%p on %A, %B %-d %Y')}\r\n #{info}</pre>"
  # elsif reader.path(request_lines) == "/word_search?"
  #   response = "<pre> #{word_exist} </pre>"
  elsif reader.path(request_lines) == "/shutdown"
    client.close
    break
  end

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

  # puts ["Wrote this response:", headers, output].join("\n")
  # puts "\nResponse complete, exiting."

end
