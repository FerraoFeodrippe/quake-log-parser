require 'strscan'
require_relative './key_words'
require_relative './core'

module LogReader
  extend self

  def read(data, env={})
    @@buffer = StringScanner.new(data)
    matches = KeyWords.matches
    @@buffer.scan_until(matches)
    matched = @@buffer.matched

    case matched
    when KeyWords.INIT_GAME
      Core.new_game
    when KeyWords.SHUTDOWN_GAME
      Core.finish_game
    when KeyWords.CLIENT_CONNECT
      add_player
    when KeyWords.CLIENT_DISCONNECT
      remove_player
    when KeyWords.KILL
      add_kill
    when KeyWords.CLIENT_USERINFO_CHANGED 
      change_user                         
    end
  end  
  
  private 

  def add_player
    @@buffer.scan_until(/\d+/)
    id = @@buffer.matched
    Core.add_player(id.to_i) 
  end

  def remove_player
    @@buffer.scan_until(/\d+/)
    id = @@buffer.matched
    Core.remove_player(id.to_i)
  end

  def change_user
    @@buffer.scan_until(/\d+/)
    id = @@buffer.matched
    @@buffer.scan_until(/n\\(.+?)\\/)
    name = @@buffer[1]
    Core.change_user(id.to_i,name)
  end

  def add_kill
    @@buffer.scan_until(/(\d+) (\d+) (\d+)/)
    w_kill = @@buffer[1].to_i
    w_killed = @@buffer[2].to_i
    mod_death = @@buffer[3].to_i
    Core.add_kill(w_kill, w_killed, mod_death)
  end
end