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
    log = File.open(@file_name)
    if @check_parse
      LogParser.parse(log.read)
    else
      log.readlines.each{|line| LogReader.read(line) }
    end
    log.close
  end
end
