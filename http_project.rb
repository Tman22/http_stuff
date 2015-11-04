require 'socket'
require './reader'
require './date_time'
require './output'
require './word_validation'
require './game'
require './server'

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

  show = Output.new(client)
  parser = Parsers.new(request_lines)


  puts "Got this request: (#{request_count})"
  puts "Sending response."

  case parser.path
  when "/" then response = parser.home
  when "/hello" then response = parser.hello(request_count)
  when "/datetime" then response = parser.date_time
  when "/word_search" then response = parser.word_search
  when "/shutdown" then response = parser.shutdown(request_count)
  end


  show.output(response)
    if parser.path == "/shutdown"
      client.close
      break
    end

  # unless reader.path(request_lines "/favicon.ico")
end
