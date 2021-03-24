require "io/console"
require "faker"

class Game
  def run
    display_clear
    welcome_message
    generate_word
    loop do
      # debug_words
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

  def generate_word
    puts "Welcome to hangman!\n\n"
    puts "Please choose a word category..."
    puts "1. League of Legends"
    puts "2. Half Life"
    puts "3. Band Names"
    puts "4. Basketball Players"
    puts "5. Movie Titles"
    puts "\n"
    loop do
      @category_selection = gets.chomp.to_i
      if @category_selection == 1
        @word = (Faker::Games::LeagueOfLegends.champion.upcase)
        @category = "League of Legends"
        break
      elsif @category_selection == 2
        @word = (Faker::Games::HalfLife.character.upcase)
        @category = "Half Life"
        break
      elsif @category_selection == 3
        @word = (Faker::Music.band.upcase)
        @category = "Band Names"
        break
      elsif @category_selection == 4
        @word = (Faker::Sports::Basketball.player.upcase)
        @category = "Basketball Players"
        break
      elsif @category_selection == 5
        @word = (Faker::Movie.title.upcase)
        @category = "Movie Titles"
        break
      elsif @category_selection == 0
        @word = "MONKE"
        500.times do
          puts "MONKE MODE ACTIVATED"
          sleep(0.001)
        end
        break
      else
        puts "Invalid selection, please choose again."
      end
    end
    @lives = @word.length + 3
    @guessed_letters = []
    word_arr_whitespace = (@word.split("")).uniq
    @word_arr = word_arr_whitespace.select { |char| char != " " }
    display_clear
    puts "I'm going to give you #{@lives} chances\nto guess letters in the #{@category}\nthemed word I'm thinking of.\n\nGood luck!"
    press_any_key
    display_clear
  end

  def display_word
    puts "Your selected category is #{@category}\n\n"
    puts "The word is: \n"
    @word.chars.each do |char|
      if char == " "
        print "  "
      else
        if @guessed_letters.include?(char.upcase)
          print "#{char.upcase} "
        else
          print "_ "
        end
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
    if @lives == 0
      display_clear
      puts "Sorry, you lose...\n\nThe word was #{@word}.\n\nPlay again? Y/N"
      continue = gets.chomp.upcase
      if continue == "N"
        exit
      else
        run
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
      puts "\nYou win!\nWould you like to play again? Y/N"
      continue = gets.chomp.upcase
      if continue == "N"
        exit
      else
        run
      end
    end
  end

  def welcome_message
  end

  def display_clear
    system("clear")
  end

  def press_any_key
    print "\nPress any key to continue..."
    STDIN.getch
  end

  def debug_words
    puts "word\n #{@word}"
    puts "word_arr\n #{@word_arr}"
    puts "guess\n #{@guess}"
    puts "guessed_letters\n #{@guessed_letters}"
  end
end
