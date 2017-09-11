class Player
  attr_reader :id, :kills, :name

  def initialize (id, name='')
    @id = id
    @name = name
    @kills = 0
  end

  def ==(player)
    @name == player.name 
  end

  def add_kill
    @kills+=1
  end

  def remove_kill
    @kills-=1
  end

  def change_name (name)
    @name= name
  end

  def name_kills
    "#{@name}: #{@kills}"
  end

  def to_s
    @name
  end
end