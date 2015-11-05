require 'socket'
require 'minitest/autorun'
require './lib/output'
#require './lib/output'

class OutputTest < Minitest::Test

  def test_output_object_exists
    server = TCPServer.new(9292)
    client = server.accept
    show = Output.new(client)
    assert show
    client.close
  end

  def test_output
    skip
  end

end
