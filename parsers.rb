require './lib/reader'
require './lib/word_validation'
require './lib/date_time'
require './lib/output'

class Parsers
  attr_reader :info, :reader, :date, :path
  def initialize(request_lines)
    @reader = Reader.new(request_lines)
    @date = Date_time.new.date_format
    @path = reader.path
  end

  def home
    "<pre></pre>"
  end

  def hello(request_count)
    "<pre> Hello world (#{request_count})</pre>"
  end

  def date_time
    "<pre>#{date}</pre>"
  end

  def word_search
    word = Word_validation.new(reader.values)
    # word_output = word.word_output
    "<pre>#{word.word_output}</pre>"
  end

  def shutdown(request_count)
    "<pre> Total requests: #{request_count} </pre>"
  end

end
