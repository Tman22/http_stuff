require 'minitest/autorun'
require 'socket'
require './server'
#require './lib/server'



class ServerTest < Minitest::Test

  attr_reader :tcp_server, :client

  # error for wrong number of argumenets...1 for 0...?
  def initialize
    @tcp_server = TCPServer.new(9292)
    @client = @tcp_server.accept
  end

  def test_server_exists
    assert @tcp_server
  end

  def test_server_accepts_client
    assert @client
  end

  def test_server_closes_connection
    assert @client
    @client.close
    refute @client
  end

end
