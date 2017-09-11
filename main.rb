load "log_parser.rb"
load "core.rb"

def start
  f = File.open("games.txt", "r")
  f.each_line{ |line|
    LogParser.parse(line).action
  }
  f.close  
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
    puts "invalid command, commands avaliables: show_game, show_rank"
end



