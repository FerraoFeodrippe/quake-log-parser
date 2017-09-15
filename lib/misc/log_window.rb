require 'green_shoes'
require_relative "../processes/core"
require_relative "./log_file"

module LogWindow
  extend self

  def show
    Shoes.app title:'LogParser' do
      flow do
        para 'File: ', width:30, margin:10
        button 'Chose file', width:40, margin:5 do
          @file_name.text = ask_open_file
          LogFile.file(@file_name.text)
          begin
            LogFile.start
            @change.text = 'Sucess Parse'
          rescue Exception => e
            @change.text = e.message
          end
        end
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
        @check_parse = check width: 100 do
          LogFile.parse_on(@check_parse.checked?)
        end
        para 'Use Parse?', width: 200, margin: 5
      end
      @change = edit_box "OUTPUT", state: "readonly", width: 500, height:300, margin_left:10

    end   
  end

end