require 'minitest/autorun'
require './server'
#require './lib/server'

# getting error that 9292 is already in use. but it works for the output_test so i don't know what's going on.

class ServerTest < Minitest::Test

  def test_server_exists
    server = TCPServer.new(9292)
    assert server
    client = server.accept
    client.close
  end

  def test_server_accepts_client
    server = TCPServer.new(9292)
    client = server.accept
    assert client
    client.close
  end

  def test_server_closes_connection
    server = TCPServer.new(9292)
    client = server.accept
    assert client
    client.close
    refute client
  end

end
