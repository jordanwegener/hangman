require "io/console"

class Game
  def initialize
    @words = ["GAME", "INDEX", "RUBY", "PROGRAMMER", "CODE", "BUG"]
    @word = @words.sample
    @lives = @word.length + 2
    @guessed_letters = []
    @word_arr = (@word.split("")).uniq
  end

  def run
    display_clear
    display_break
    welcome_message
    display_break
    press_any_key
    display_clear
    loop do
      display_word
      check_win
      display_lives
      display_guesses
      guess_word
      check_guess
      check_lives
      display_clear
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
    puts "\n"
  end

  def display_guesses
    unless @guessed_letters.empty?
      puts "\nYou've already guessed these letters: "
      @guessed_letters.each do |char|
        print "#{char.upcase} "
      end
    end
  end

  def guess_word
    loop do
      puts "\n\nGuess a letter..."
      @guess = gets.chomp.upcase
      if @guessed_letters.include?(@guess)
        display_clear
        display_word
        puts "\nYou already guessed that letter"
        display_guesses
      else
        @guessed_letters.push(@guess)
        break
      end
    end
  end

  def check_lives
    if @lives <= 0
      display_clear
      puts "Sorry, you lose...\n\nPlay again? Y/N"
      continue = gets.chomp.upcase
      if continue == "N"
        exit
      else
        @word = @words.sample
        @lives = @word.length + 2
        @guessed_letters = []
        @word_arr = (@word.split("")).uniq
        display_clear
        welcome_message
      end
    end
  end

  def check_guess
    unless @word.upcase.include?(@guess)
      @lives -= 1
    end
  end

  def display_break
    puts "\n- - - - - - - - - - - - - - - -"
  end

  def display_lives
    puts "\nYou have #{@lives} lives left"
  end

  def check_win
    if (@word_arr - (@guessed_letters & @word_arr)).empty?
      puts "You win!"
      exit
    end
  end

  def welcome_message
    puts "Welcome to hangman!\n\nI'm going to give you #{@lives} chances\nto guess letters in the word I'm\nthinking of.\n\nGood luck!"
  end

  def display_clear
    system("clear")
  end

  def press_any_key
    print "\nPress any key to continue..."
    STDIN.getch
  end
end
