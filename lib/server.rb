require 'socket'
require './lib/output'
require './lib/parsers'
require './lib/game'
require './lib/reader'

def get_request(client, array)
  while line = client.gets and !line.chomp.empty?
    array << line.chomp
  end
end

def get_request_plus_guess(client, array)
  until webkits == 2
    line = client.gets
    webkits += 1 if line.start_with?("------")
    array << line.chomp
  end
end


tcp_server = TCPServer.new(9292)
request_count = 0
empty_line_counter = 0
game = Game.new
guess = []

loop do
  client = tcp_server.accept
  request_lines = []
  request_number = []
  webkits = 0

  get_request(client, request_lines)

  show = Output.new(client)
  parser = Parsers.new(request_lines)
  reader = Reader.new(request_lines)

  unless reader.path == "/favicon.ico"
    request_count += 1
    puts "Ready for a request"
    puts "Got this request: (#{request_count})"
    puts "Sending response."

    case reader.find_verb
    when "GET"
      case reader.path
      when "/" then response = parser.home
      when "/hello" then response = parser.hello(request_count)
      when "/datetime" then response = parser.date_time
      when "/word_search" then response = parser.word_search
      when "/game" then response = game.check_guess(guess)
      when "/shutdown" then response = parser.shutdown(request_count)
      end
    when "POST"
      case reader.path
      when "/start_game"
        response = game.start_game
      when "/game"
        get_request_plus_guess(client, request_number)
        guess = request_number[3].to_i
        client.puts "HTTP/1.1 302 Found\r\nLocation: http://127.0.0.1:9292/game"
      end
    end

    show.output(response, reader.read)

    if reader.path == "/shutdown"
      client.close
      break
    end
  end
  client.close
end
