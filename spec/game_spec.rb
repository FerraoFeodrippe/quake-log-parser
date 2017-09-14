require_relative '../lib/entities/game'
require_relative '../lib/entities/player'

describe Game do
  before :each do
    @game = Game.new('game_1')
    @player1 = Player.new(1,'Player1')
    @player2 = Player.new(2,'Player2')
    @game.add_player @player1
    @game.add_player @player2
  end

  context 'adding a new player' do
    it 'should add a player to the game' do
      player = Player.new(3,'Player3')
      expect {
        @game.add_player(player)
        @game.players
    }.to change{@game.players.size}.by(1)
    end

    it 'should holds the same player on the list, same name' do
      player = Player.new(3,'Player3')
      @game.add_player(player)
      expect(@game.players[-1]).to eq Player.new(3,'Player3')
    end
  end

  context 'removing a player' do
    it 'should remove a player from the game' do
      expect {
        @game.remove_player(1)
        @game.players
    }.to change{@game.players.size}.by(-1)
    end

    it 'should be sure the player is not in the list' do
      @game.remove_player(1)
      find = @game.player_index('Player1')
      expect(find).to be_nil
    end
  end  

  context 'adding kills' do
    it 'should add 1 kill to the kills\' count' do
      expect{
        @game.add_kill(1,2,0)
        @game.kills
    }.to change {@game.kills}.by(1)
    end
  end
end