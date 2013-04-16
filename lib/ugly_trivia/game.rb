module UglyTrivia
  class Game
    def  initialize
      @players = []
      @places = Array.new(6, 0)
      @purses = Array.new(6, 0)
      @in_penalty_box = Array.new(6, 0)
      @questions = {
        'Pop' => 0,
        'Science' => 0,
        'Sports' => 0,
        'Rock' => 0
      }
      @current_player = 0
      @is_getting_out_of_penalty_box = false
    end

    def is_playable?
      how_many_players >= 2
    end

    def add(player_name)
      @players.push player_name
      @places[how_many_players] = 0
      @purses[how_many_players] = 0
      @in_penalty_box[how_many_players] = false

      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"

      true
    end

    def how_many_players
      @players.length
    end

    def roll(roll)
      puts "#{@players[@current_player]} is the current player"
      puts "They have rolled a #{roll}"

      if @in_penalty_box[@current_player]
        if roll % 2 != 0
          @is_getting_out_of_penalty_box = true

          puts "#{@players[@current_player]} is getting out of the penalty box"
          @places[@current_player] = (@places[@current_player] + roll) % 12

          puts "#{@players[@current_player]}'s new location is #{@places[@current_player]}"
          puts "The category is #{current_category}"
          ask_question
        else
          puts "#{@players[@current_player]} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
          end

      else

        @places[@current_player] = (@places[@current_player] + roll) % 12

        puts "#{@players[@current_player]}'s new location is #{@places[@current_player]}"
        puts "The category is #{current_category}"
        ask_question
      end
    end

    def was_correctly_answered
      if @in_penalty_box[@current_player]
        if @is_getting_out_of_penalty_box
          puts 'Answer was correct!!!!'
          @purses[@current_player] += 1
          puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."

          winner = did_player_win()
          @current_player += 1
          @current_player = 0 if @current_player == @players.length

          winner
        else
          @current_player += 1
          @current_player = 0 if @current_player == @players.length
          true
        end



      else

        puts "Answer was corrent!!!!"
        @purses[@current_player] += 1
        puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."

        winner = did_player_win
        @current_player += 1
        @current_player = 0 if @current_player == @players.length

        return winner
      end
    end

    def wrong_answer
  		puts 'Question was incorrectly answered'
  		puts "#{@players[@current_player]} was sent to the penalty box"
  		@in_penalty_box[@current_player] = true

      @current_player += 1
      @current_player = 0 if @current_player == @players.length
  		return true
    end

  private

    def ask_question
      return nil if @questions[current_category] > 50
      puts "#{current_category} Question #{@questions[current_category]}"
      @questions[current_category] += 1
    end

    def current_category
      return 'Pop' if @places[@current_player] == 0
      return 'Pop' if @places[@current_player] == 4
      return 'Pop' if @places[@current_player] == 8
      return 'Science' if @places[@current_player] == 1
      return 'Science' if @places[@current_player] == 5
      return 'Science' if @places[@current_player] == 9
      return 'Sports' if @places[@current_player] == 2
      return 'Sports' if @places[@current_player] == 6
      return 'Sports' if @places[@current_player] == 10
      return 'Rock'
    end

    def did_player_win
      !(@purses[@current_player] == 6)
    end
  end
end
