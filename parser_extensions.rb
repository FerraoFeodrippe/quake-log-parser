require './core.rb'

module TopNode
  def action
      if definition.elements[0].identifier.respond_to? :action
        definition.elements[0].identifier.action(definition.elements[0])
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
    id = parent.suffix.elements[0].text_value.to_i
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
    id = parent.suffix.elements[0].text_value.to_i
    Core.remove_player(id)
  end 
end

module ClientUserinfoChanged
  def action(parent)
    id = parent.suffix.elements[0].text_value.to_i
    name = parent.suffix.name.text_value
    Core.change_user(id, name)
  end 
end

module ActionKill
  def action(parent)
    w_kill = parent.suffix.n1.text_value.to_i
    w_killed = parent.suffix.n2.text_value.to_i
    mod_death = parent.suffix.n3.text_value.to_i
    Core.add_kill(w_kill, w_killed, mod_death)
  end 
end

module ActionItem
  def action(parent)
    #not implemented
  end 
end