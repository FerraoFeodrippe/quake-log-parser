require_relative '../lib/processes/log_parser'

describe LogParser do
  context  'match with time at start' do
    it 'should accept format HH:MM' do
      data =" 20:37 InitGame: \\sv_floodProtect\\1\\sv_maxPing\\0\\sv_minPing\\0\\sv_maxRate\\10000\\sv_minRate\\0\\sv_hostname\\Code Miner Server\\g_gametype\\0\\sv_privateClients\\2\\sv_maxclients\\16\\sv_allowDownload\\0\\bot_minplayers\\0\\dmflags\\0\\fraglimit\\20\\timelimit\\15\\g_maxGameClients\\0\\capturelimit\\8\\version\\ioq3 1.36 linux-x86_64 Apr 12 2009\\protocol\\68\\mapname\\q3dm17\\gamename\\baseq3\\g_needpass\\0"
      expect( LogParser.parse(data) ).not_to be_nil
    end

    it 'should accept format H:MM' do
      data = "  0:37 InitGame: \\sv_floodProtect\\1\\sv_maxPing\\0\\sv_minPing\\0\\sv_maxRate\\10000\\sv_minRate\\0\\sv_hostname\\Code Miner Server\\g_gametype\\0\\sv_privateClients\\2\\sv_maxclients\\16\\sv_allowDownload\\0\\bot_minplayers\\0\\dmflags\\0\\fraglimit\\20\\timelimit\\15\\g_maxGameClients\\0\\capturelimit\\8\\version\\ioq3 1.36 linux-x86_64 Apr 12 2009\\protocol\\68\\mapname\\q3dm17\\gamename\\baseq3\\g_needpass\\0"
      expect( LogParser.parse(data) ).not_to be_nil      
    end  
  end

  context 'identifiers check' do
    it 'should accept "InitGame" in grammar' do
      data= ' 12:00 InitGame:'
      expect( LogParser.parse(data) ).not_to be_nil
    end

    it 'should accept "ShutdownGame" in grammar' do
      data= ' 12:00 ShutdownGame:'
      expect( LogParser.parse(data) ).not_to be_nil
    end

    it 'should accept "ClientConnect" in grammar' do
      data= ' 12:00 ClientConnect:'
      expect( LogParser.parse(data) ).not_to be_nil
    end

    it 'should accept "ClientDisconnect" in grammar' do
      data= ' 12:00 ClientDisconnect:'
      expect( LogParser.parse(data) ).not_to be_nil
    end

    it 'should accept "ClientUserinfoChanged" in grammar' do
      data= ' 12:00 ClientUserinfoChanged:'
      expect( LogParser.parse(data) ).not_to be_nil
    end

    it 'should accept "ClientBegin" in grammar' do
      data= ' 12:00 ClientBegin:'
      expect( LogParser.parse(data) ).not_to be_nil
    end

    it 'should accept "Kill" in grammar' do
      data= ' 12:00 Kill:'
      expect( LogParser.parse(data) ).not_to be_nil
    end

    it 'should accept "Item" in grammar' do
      data= ' 12:00 Item:'
      expect( LogParser.parse(data) ).not_to be_nil
    end
  end

  context 'ignore line' do
    it 'should ignore line starting with "-" caracter after time' do
      data = ' 20:37 ------------------------------------------------------------'
      expect( LogParser.parse(data) ).not_to be_nil
    end
  end

  context 'check identifiers with parameters' do
    it 'read parameters from InitGame' do
      data = " 20:37 InitGame: \\sv_floodProtect\\1\\sv_maxPing\\0\\sv_minPing\\0\\sv_maxRate\\10000\\sv_minRate\\0\\sv_hostname\\Code Miner Server\\g_gametype\\0\\sv_privateClients\\2\\sv_maxclients\\16\\sv_allowDownload\\0\\bot_minplayers\\0\\dmflags\\0\\fraglimit\\20\\timelimit\\15\\g_maxGameClients\\0\\capturelimit\\8\\version\\ioq3 1.36 linux-x86_64 Apr 12 2009\\protocol\\68\\mapname\\q3dm17\\gamename\\baseq3\\g_needpass\\0"
      expect( LogParser.parse(data) ).not_to be_nil
    end
    it 'read parameters from ClientConnect' do
      data = " 20:34 ClientConnect: 2"
      expect( LogParser.parse(data) ).not_to be_nil
    end
    it 'read parameters from ClientDisconnect' do
      data = " 20:34 ClientDisconnect: 2"
      expect( LogParser.parse(data) ).not_to be_nil
    end
    it 'read parameters from ClientBegin' do
      data = " 20:34 ClientBegin: 2"
      expect( LogParser.parse(data) ).not_to be_nil
    end
    it 'read parameters from ClientUserinfoChanged' do
      data = " 20:38 ClientUserinfoChanged: 2 n\\Isgalamido\\t\\0\\model\\uriel/zael\\hmodel\\uriel/zael\\g_redteam\\g_blueteam\\c1\5\\c2\\5\\hc\\100\\w\\0\\l\\0\\tt\\0\\tl\\0"
      expect( LogParser.parse(data) ).not_to be_nil
    end
    it 'read parameters from Kill' do
      data = " 21:07 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT"
      expect( LogParser.parse(data) ).not_to be_nil
    end
    it 'read parameters from Item' do
      data = " 20:42 Item: 2 item_armor_body"
      expect( LogParser.parse(data) ).not_to be_nil
    end
  end

end