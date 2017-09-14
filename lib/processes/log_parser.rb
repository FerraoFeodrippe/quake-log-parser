require_relative '../extensions/parser_extensions'

module LogParser
  Treetop.load(File.join(__dir__, 'simple_log.treetop'))
  @@parser = SimpleLogParser.new
  def self.parse(data, env = {})
    tree = @@parser.parse(data)
    if(tree.nil?)
      raise Exception, "Parse error at offset: #{@@parser.index}; At line #{env[:n]}:#{data}"
    end
    tree
  end
end

