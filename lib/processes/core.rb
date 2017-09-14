require_relative '../entities/game'

module Core
  @@games = []

  extend self

  def new_game
    name = "game_#{@@games.size + 1}" 
    @actualGame = Game.new (name)
  end
    
  def finish_game
    @@games << @actualGame
  end

  def add_player(id)
    @actualGame.add_player(Player.new(id)) 
  end

  def remove_player(id)
    @actualGame.remove_player(id)
  end

  def change_user(id, name)
    @actualGame.change_user(id,name)
  end

  def add_kill(w_kill, w_killed, mod_death)
    @actualGame.add_kill(w_kill, w_killed, mod_death)
  end

  def get_games
    @@games
  end

  def get_rank
    players = []
    @@games.each do |game|
      g_players = game.players
      g_players.each{ |pl| 
        if index = players.index{|x| x.name == pl.name} 
          players.at(index).add_kill(pl.kills)
        else
          players << Player.new(pl.id, pl.name, pl.kills)
        end
    }
    end
    players = players.sort {|x,y| y.kills <=> x.kills}.map{|x| x.name_kills}
  end
end