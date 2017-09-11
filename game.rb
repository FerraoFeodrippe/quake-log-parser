require './player'

class Game

  attr_reader :name, :players, :kills 

  def initialize (name)
    @name = name
    @players = []
    @kills = 0
  end

  def add_player (player)
    players << player
  end

  def remove_player (id)
    players.delete_if {|p| p.id == id}
  end

  def add_kill(w_kill, w_killed, mod_death)
    player2 = players[player_index(w_killed)]
    if (w_kill == 1022) || (w_kill == w_killed)
      player2.remove_kill
    elsif
      player1 = players[player_index(w_kill)]
      player1.add_kill
    end
    @kills+=1
  end

  def player_kills
    players.collect {|p| p.name_kills}
  end

  def player_index(id)
    players.index{ |p| p.id == id }
  end

  def change_user(id, name)
    player = players[player_index(id)]
    player.change_name(name)
  end

  def show_score
    <<~SCORE
      #{@name}:
        players: 
          #{@players.map{|p| p.to_s}}
        total kills: 
          #{@kills}
        player kills:
          #{player_kills.join("\n    ")} 
    SCORE
  end

  def to_s
    @name
  end
end
