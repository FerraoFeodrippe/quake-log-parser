require './core.rb'

module TopNode
  def action
    if elements[1].respond_to? :identifier
        elements[1].identifier.action(elements[1])
    end
  end
end

module NewGame
  def action(parent)
    Core.new_game
  end
end

module FinishGame
  def action(parent)
    Core.finish_game
  end
end

module ClientConnect
  def action(parent)
    id = parent.params.text_value.to_i
    Core.add_player(id)
  end    
end

module ClientBegin
  def action(parent)
    #not implemented
  end     
end

module ClientDisconnect
  def action(parent)
    id = parent.params.text_value.to_i
    Core.remove_player(id)
  end 
end

module ClientUserinfoChanged
  def action(parent)
    id = parent.params.number.text_value.to_i
    name = parent.params.name.text_value
    Core.change_user(id, name)
  end 
end

module ActionKill
  def action(parent)
    w_kill = parent.params.n1.text_value.to_i
    w_killed = parent.params.n2.text_value.to_i
    mod_death = parent.params.n3.text_value.to_i
    Core.add_kill(w_kill, w_killed, mod_death)
  end 
end

module ActionItem
  def action(parent)
    #not implemented
  end 
end