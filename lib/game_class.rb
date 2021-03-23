class Game
  def initialize
    @words = ["alpha", "beta", "gamma"]
    @word = @words.sample
    @lives = @word.length + 2
    @guessed_letters = []
  end

  def run
    welcome_message
    loop do
      display_lives
      display_word
      guess_word
      check_guess
      check_win
      check_lives
    end
  end

  def display_word
    @word.chars.each do |char|
      if @guessed_letters.include?(char.upcase)
        print "#{char.upcase} "
      else
        print "_ "
      end
    end
  end

  def guess_word
    loop do
      puts "\nGuess a letter"
      @guess = gets.chomp.upcase
      if @guessed_letters.include?(@guess)
        puts "\nYou already guessed that letter"
      else
        @guessed_letters.push(@guess)
        break
      end
    end
  end

  def check_lives
    if @lives <= 0
      puts "Sorry, you lose!\nPlay again? Y/N"
      continue = gets.chomp.upcase
      if continue == "N"
        exit
      else
        @word = @words.sample
        @lives = @word.length + 2
        @guessed_letters = []
      end
    end
  end

  def check_guess
    unless @word.include?(@guess)
      @lives -= 1
    end
  end

  def display_lives
    puts "\n\nYou have #{@lives} lives left"
  end

  def check_win
    if (@guessed_letters.include?(@word))
      puts "You win!"
      exit
    end
  end

  def welcome_message
    puts "Welcome to hangman"
  end
end
