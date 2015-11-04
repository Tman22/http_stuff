require 'socket'
require './reader'
require './date_time'
require './output'
require './word_validation'
require './game'
require './path'

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
  date = Date_time.new.date_format
  reader = Reader.new(request_lines)
  info = reader.read
  # word_exist = reader.word_exist(request_lines)

  puts "Got this request: (#{request_count})"
  puts "Sending response."

  case reader.find_verb
  when "GET"
    if reader.path == "/"
      response = "<pre>#{info}\n #{request_lines.inspect} </pre>"
      show.output(response)
    elsif reader.path == "/hello"
      response = "<pre> Hello world (#{request_count})\r\n #{info}\r\n </pre>"
      show.output(response)
    elsif reader.path == "/datetime"
      response = "<pre>#{date}\r\n #{info}</pre>"
      show.output(response)
    elsif reader.path == "/word_search"
      words = Word_validation.new(reader.values)
      word_output = words.word_output
      response = "<pre>#{word_output} \r\n #{info} </pre>"
      show.output(response)
    elsif reader.path == "/game"
      # game = Game.new
      response = "<pre> #{game.check_guess(reader.values.join.to_i)} \r\n #{info}</pre>"
      show.output(response)
    elsif reader.path == "/shutdown"
      response = "<pre> Total requests: #{request_count}</pre>"
      show.output(response)
      client.close
      break
    end
  when "POST"
    if reader.path == "/start_game"
      game = Game.new
      response = "<pre> START GAME WOOT! \r\n #{info}</pre>"
      show.output(response)
    elsif reader.path == "/game"
        response = "<pre> #{game.check_guess(reader.values.join.to_i)} \r\n #{info}</pre>"
        show.output(response)
    end
  end
  # unless reader.path(request_lines "/favicon.ico")


end
