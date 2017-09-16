require_relative "../processes/log_parser"
require_relative "../processes/log_reader"

module LogFile
    @check_parse = true
  extend self

  def file(name)
    @file_name= name
  end

  def parse_on(check_parse)
    @check_parse = check_parse
  end

  def start
    log_lines = IO.readlines(@file_name)
    log_method = @check_parse == true ? LogParser.method(:parse) : LogReader.method(:read)
    log_lines.each_with_index do |line, n|
      log_method.call(line,:n => n)
    end
  end
end
