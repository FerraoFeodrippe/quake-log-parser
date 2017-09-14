require_relative "./processes/log_parser"
require_relative "./processes/log_reader"
require_relative "./processes/core"

def start(input)
  log_lines = IO.readlines("../data/games.txt")
  log_lines.each_with_index do |line, n|
    if input.include? '-read'
      LogReader.read(line)
    else
      LogParser.parse(line, {:n => n+1}).action 
    end
  end 
end

input = ARGV

case 
  when input.include?('show_games')
    start(input)
    Core.get_games.each do |game|
        puts game.show_score
    end
  when
    input.include?('show_rank')
    start(input)
    puts Core.get_rank
  else
    puts "invalid command, commands avaliables: show_games, show_rank"
end



