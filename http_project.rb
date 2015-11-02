require 'socket'                  # => true
require_relative 'reader'                  # ~> LoadError: cannot load such file -- reader
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


  puts "Got this request: (#{request_count})"

  puts "Sending response."
  if reader.path(request_lines) == "/"
    response = "<pre>#{info}</pre>"
  elsif reader.path(request_lines) == "/hello"
    response = "<pre> Hello world (#{request_count})\r\n #{info}\r\n </pre>"
  end
  # response = "<pre>" + request_lines.join("\n") + "</pre>"
  # output = "<html><head></head><body>#{request_count}\r\n #{response}\r\n #{request_lines.inspect}</body></html>"
  output = "<html><head></head><body>#{response}</body></html>"

  # headers = ["http/1.1 200 ok",
  #           "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
  #           "server: ruby",
  #           "content-type: text/html; charset=iso-8859-1",
  #           "content-length: #{output.length}\r\n\r\n"].join("\r\n")

  # client.puts headers
  client.puts output

  # puts ["Wrote this response:", headers, output].join("\n")
  # puts "\nResponse complete, exiting."

end
client.close

# ~> LoadError
# ~> cannot load such file -- reader
# ~>
# ~> /Users/taylormoore/.rvm/rubies/ruby-2.2.1/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/taylormoore/.rvm/rubies/ruby-2.2.1/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/taylormoore/turing/1module/http_stuff/http_project.rb:2:in `<main>'
