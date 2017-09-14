require_relative '../processes/core'
require 'treetop'

module ParserExtensions
  class TopNode < Treetop::Runtime::SyntaxNode
    def action
        if definition.elements[0].identifier.respond_to? :action
          definition.elements[0].identifier.action(definition.elements[0])
        end
    end
  end
  
  class NewGame < Treetop::Runtime::SyntaxNode
    def action(parent)
      Core.new_game
    end
  end
  
  class FinishGame < Treetop::Runtime::SyntaxNode
    def action(parent)
      Core.finish_game
    end
  end
  
  class ClientConnect < Treetop::Runtime::SyntaxNode
    def action(parent)
      id = parent.suffix.elements[0].text_value.to_i
      Core.add_player(id)
    end    
  end
  
  class ClientBegin < Treetop::Runtime::SyntaxNode
    def action(parent)
      #not implemented
    end     
  end
  
  class ClientDisconnect < Treetop::Runtime::SyntaxNode
    def action(parent)
      id = parent.suffix.elements[0].text_value.to_i
      Core.remove_player(id)
    end 
  end
  
  class ClientUserinfoChanged < Treetop::Runtime::SyntaxNode
    def action(parent)
      id = parent.suffix.elements[0].text_value.to_i
      name = parent.suffix.name.text_value
      Core.change_user(id, name)
    end 
  end
  
  class ActionKill < Treetop::Runtime::SyntaxNode
    def action(parent)
      w_kill = parent.suffix.n1.text_value.to_i
      w_killed = parent.suffix.n2.text_value.to_i
      mod_death = parent.suffix.n3.text_value.to_i
      Core.add_kill(w_kill, w_killed, mod_death)
    end 
  end
  
  class ActionItem < Treetop::Runtime::SyntaxNode
    def action(parent)
      #not implemented
    end 
  end
end
