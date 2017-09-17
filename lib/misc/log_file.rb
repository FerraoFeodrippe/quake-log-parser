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
      tree = LogParser.parse(log.read)
      tree.action   
      #if need to use for test, split the large by games
      #save_games_log(tree)
    else
      log.readlines.each{|line| LogReader.read(line) }
    end
    log.close
  end

  def get_games(tree)
    tree.elements[0].elements
  end

  def get_game_log(games,n)
    if n > 0
      games[n].text_value[1..-1]
    else
      games[n].text_value
    end
  end

  def save_games_log(tree)
    games = get_games(tree)
    dir= File.join(__dir__, "../../data/")
    games.each_index do |i| 
      File.open(dir + "game_#{i} from |#{File.basename(@file_name)}|.txt", "w") do |file|
        file.write(get_game_log(games,i))
      end
    end
  end

end
