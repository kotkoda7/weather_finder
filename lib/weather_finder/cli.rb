class WeatherFinder::CLI
USA_ZIP_CODES = [[*35801..35816],
[*99501..99524],[*85001..85055],[*72201..72217],[*94203..94209],
[*90001..90089],[*90209..90213],[*80201..80239],[*06101..06112],
[*19901..19905],[*20001..20020],[*32501..32509],[*33124..33190],
[*32801..32837],[*30301..30381],[*96801..96830],[83254],[*60601..60641],
[*62701..62709],[*46201..46209],[*52801..52809],[*50301..50323],
[*67201..67221],[*41701..41702],[*70112..70119],[*04032..04034],
[*21201..21237],[*02101..02137],[49036],[*49734..49735],[*55801..55808],
[*39530..39535],[*63101..63141],[59044],[*68901..68902],[*89501..89513],
[03217],[07039],[*87500..87506],[*10001..10048],[27565],[58282],
[*44101..44179],[*74101..74110],[*97201..97225],[*15201..15244],
[*02840..02841],[29020],[*57401..57402],[*37201..37222],[*78701..78705],
[*84321..84323],[05751],[24517],[*98004..98009],[25813],[*53201..53228],
[82941]]

  def call
    input = ""

    while input != "exit"
      puts "What is the zip code you would like to know the weather at?"
      puts "exit to quit"
      input = gets.chomp
      state = self.zip_code?(input)
      if state
        weather(input)
      elsif !state && input.downcase != 'exit'
        puts "Invalid Input"
      end
    end# end of while loop
    self.goodbye
  end # call method end

  def weather(zip_code)# prints current weather
    weather = WeatherFinder::Scrapper.basic_weather(zip_code)
    puts "**************************************"
    puts "It is currently #{weather[0]}"
    puts "But it feels like #{weather[2]}"
    puts "With a UV index of #{weather[1]}"
    puts "**************************************"
    self.menu(zip_code)
  end

  def weather_info
  end# end of weather_info

  def menu(zip_code)
    input = "blank"

    while input.downcase != 'back' || input.downcase != 'exit'

      puts "Would you like to look at the hourly or 10 day forcast?"
      puts "Type 'hourly' or '10 day' to choose."
      puts "type 'back' to choose a different zip code."
      puts "Or type 'exit' to quit."
      input = gets.chomp

      if input.downcase == 'hourly'
        puts "Hourly data"
      elsif input.downcase == '10 day' || input.downcase == 'ten day'
        puts "10 day data"
      elsif input.downcase == 'back'
        self.call
      elsif input.downcase == 'exit'
        self.goodbye
      else
        puts "Do not understand entry."
        puts "Please enter a valid choice."
      end#end of if
    end#end of while
  end#end of menu

  def goodbye # prints goodbye messages and exits program
    puts "cya later nerd!"
    exit
  end

  def zip_code?(zip_code)
    valid = false

    USA_ZIP_CODES.each do |state|
      state.each do |zip|
        if zip == zip_code.to_i
          valid = true
        end
      end
      valid
    end

  end
end
