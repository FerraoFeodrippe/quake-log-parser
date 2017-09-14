require_relative "./processes/log_parser"
require_relative "./processes/core"

def start
  log_lines = IO.readlines("../data/games.txt")
  log_lines.each_with_index do |line, n|
    LogParser.parse(line, {:n => n+1}).action
  end 
end

input = ARGV

case 
  when input.include?('show_games')
    start
    Core.get_games.each do |game|
        puts game.show_score
    end
  when
    input.include?('show_rank')
    start
    puts Core.get_rank
  else
    puts "invalid command, commands avaliables: show_games, show_rank"
end



