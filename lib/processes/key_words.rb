module KeyWords
  @@key_words = [
    'InitGame:',               #0
    'ShutdownGame:',           #1
    'ClientConnect:',          #2
    'ClientDisconnect:',       #3 
    'Kill:',                   #4
    'ClientUserinfoChanged:'   #5
]

  extend self

  def INIT_GAME; @@key_words[0]; end
  def SHUTDOWN_GAME; @@key_words[1]; end
  def CLIENT_CONNECT; @@key_words[2]; end
  def CLIENT_DISCONNECT; @@key_words[3]; end
  def KILL; @@key_words[4]; end
  def CLIENT_USERINFO_CHANGED; @@key_words[5]; end


  # retorna um regex da união das @@key_words
  def matches
    @@matches ||= Regexp.new(@@key_words.join('|'))
  end
end