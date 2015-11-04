require './reader'
require './word_validation'
require './game'
require './date_time'
require './output'

class Parsers
  attr_reader :info, :reader, :date, :path
  def initialize(request_lines)
    @reader = Reader.new(request_lines)
    @date = Date_time.new.date_format
    @info = reader.read
    @path = reader.path
    # @request_count = count
  end

  def home
    "<pre>#{info}\n </pre>"
  end

  def hello(request_count)
    "<pre> Hello world (#{request_count})\r\n #{info}\r\n </pre>"
  end

  def date_time
    "<pre>#{date}\r\n #{info}</pre>"
  end

  def word_search
    word = Word_validation.new(reader.values)
    word_output = word.word_output
    "<pre>#{word_output} \r\n #{info} </pre>"
  end

  def shutdown
    "<pre> Total requests: </pre>"
  end
end
