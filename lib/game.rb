require_relative '../config/environment.rb'

class Game
  attr_reader :game_status, :away_name, :home_name, :away_final_score, :home_final_score

  def initialize (game_info)
    @game_status = game_info.css("tr.sb-linescore th.date-time").text
    @away_name = game_info.css("tr.away span.sb-team-short").text
    @home_name = game_info.css("tr.home span.sb-team-short").text
    @away_final_score = game_info.css("tr.away td.total span").text
    @home_final_score = game_info.css("tr.home td.total span").text
    @winner = winning_team
  end

  def winning_team
    winner = nil
    if @game_status == "Final"
      winner = (@away_final_score.to_i > @home_final_score.to_i ? @away_name : @home_name)
    end
    winner
  end

  def show_score
    print @game_status.rjust(12)
    print @winner == @away_name ? " > " : "   "
    puts "#{@away_final_score}".ljust(5) +"#{@away_name} @ "
    print "".rjust(12)
    print @winner == @home_name ? " > " : "   "
    puts "#{@home_final_score}".ljust(5) + "#{@home_name}"
  end
end
