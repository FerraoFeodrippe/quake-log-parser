require_relative "../processes/log_parser"
require_relative "../processes/log_reader"

module LogFile
    @check_parse = false
  extend self

  def file(name)
    @file_name= name
  end

  def parse_on(check_parse)
    @check_parse = check_parse
  end

  def start
    log_lines = IO.readlines(@file_name)
    log_lines.each_with_index do |line, n|
      if @check_parse
        LogParser.parse(line).action
      else
        LogReader.read(line)
      end
    end
  end
end
