require 'green_shoes'
require_relative "../processes/core"
require_relative "./log_file"

module LogWindow
  extend self

  def show
    Shoes.app title:'LogParser', width: 520, height:530 do
      flow do
        para 'File: ', width:30, margin:10
        button 'Choose file', width:40, margin:5 do
          if @file_name.text = ask_open_file 
            LogFile.file(@file_name.text)
            begin
              Core.clear
              LogFile.start
              @change.text = 'Sucess'
            rescue Exception => e
              @change.text = e.message
              Core.clear
            end
          end
        end
        @check_parse = check checked:true, width: 100, margin:5 do
          LogFile.parse_on(@check_parse.checked?)
        end
        para 'Use Parse?', width: 200, margin_top: 10
      end

      flow do
        para 'Chosen file: ', width:70, margin:10
        @file_name = caption '...', width:500, margin:10
      end

      para 'What would you like to see?' ,margin:10

      flow do
        button 'Show Games', margin_left:10 do
          @texto = ""
          Core.get_games.each{ |game| @texto += game.show_score}
          @change.text = @texto
        end
        button 'Show Rank', margin_left:10 do
          @texto =  Core.get_rank.join("\n")
          @change.text = @texto
        end
      end
      @change = edit_box "OUTPUT", state: "readonly", width: 500, height:300, margin_left:10

    end   
  end

end