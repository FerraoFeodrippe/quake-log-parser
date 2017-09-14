require_relative '../lib/entities/player'

describe Player do 
  before :each do
    @player = Player.new(1, 'Someone')
  end

  it 'should initialize with 0 kills' do
    expect(@player.kills).to eq 0
  end

  it 'should add a kill to a player' do
    expect{
      @player.add_kill
      @player.kills
  }.to change { @player.kills}.by(1)

  end

  it 'should remove a kill from a player' do
    expect{
      @player.remove_kill
      @player.kills
  }.to change { @player.kills}.by(-1)
  end

  it 'should change the player\'s name' do
    expect{
      name = 'Anyone'
      @player.change_name (name)
      @player.name
  }.to change { @player.name}.to('Anyone')
  end

  it 'should the names and kills into format "name: kills"' do
    expect(@player.name_kills).to eq 'Someone: 0'
  end
end