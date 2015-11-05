class Output
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def output(response)
    jigsaw = "http://cocainekings.drupalgardens.com/sites/g/files/g1324011/f/201310/Jigsaw.jpg"
    output = "<html><head></head><body>#{response}<img src=#{jigsaw}></body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
  end

  def post_output(guess)
    output = "<html><head></head><body></body></html>"
    headers = ["HTTP/1.1 302 Found\r\nLocation:http://127.0.0.1:9292/game?game=#{guess}",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{post_output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
  end

end
