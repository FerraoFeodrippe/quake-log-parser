require_relative '../processes/core'
require 'treetop'

  module LogNode
    def action
      games = elements[0].elements
      games.each{|game| game.action}
    end
  end

  module GameNode
    def action
      init_game, actions, shutdown_game = elements[1..3]
      init_game.action
      actions.elements.each{|action| action.action}
      shutdown_game.action
    end
  end
  
  module NewGameNode
    def action
      Core.new_game
    end
  end
  
  module FinishGameNode
    def action
      Core.finish_game
    end
  end

  module ActionNode
    def action
      command = elements[1]
      command.action
    end
  end
  
  module ClientConnectNode
    def action
      id = elements[2].elements[0].text_value.to_i
      Core.add_player(id.to_i)
    end    
  end
  
  module ClientBeginNode
    def action
      #not implemented
    end     
  end
  
  module ClientDisconnectNode
    def action
      id = elements[2].elements[0].text_value.to_i
      Core.remove_player(id)
    end 
  end
  
  module ClientUserinfoChangedNode
    def action
      id = elements[2].elements[0].text_value.to_i
      params = elements[4]
      param = params.elements[1]
      name = param.elements[0].elements[0].text_value
      Core.change_user(id, name)
    end 
  end
  
  module KillNode
    def action
      w_kill, w_killed, mod_death = elements[2..4].map{|e| e.text_value.to_i}
      Core.add_kill(w_kill, w_killed, mod_death)
    end 
  end
  
  module ItemNode
    def action
      #not implemented
    end 
  end

  module IgnoreNode
    def action
      #not implemented
    end
  end
