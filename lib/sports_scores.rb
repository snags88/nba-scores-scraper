require_relative '../config/environment.rb'

class Scores
  attr_reader :sport, :date_title

  def initialize(sport, date)
    @sport = sport
    @url = "http://espn.go.com/#{sport}/scoreboard?date=#{date}"
    scraper
    show_scores
  end

  def scraper
    main_data = Nokogiri::HTML(open(@url))
    @date_title = scrape_date(main_data)
    @scores = scrape_scores(main_data) #=> array of game objects
  end

  def scrape_date(data)
    data.css("div.key-dates h2").text
  end

  def scrape_scores(data)
    games_doc = data.css("div.gameDay-Container div[class*='gameCount']")
    games_doc.collect {|game_info| Game.new(game_info)} # => [#<Game1>, #<Game2>, ...]
  end

  def show_scores
    puts "========#{@date_title}========"
    if @scores
      @scores.each do |game_obj|
        game_obj.show_score
      end
    else
      puts "No games today!"
    end
  end
end