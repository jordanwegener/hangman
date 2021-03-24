# Hangman - Terminal Game

A simple guessing game. The user picks a word category and is presented with a series of underscores representing unknown characters of a randomly generated word.

## Usage

The game is started in terminal with the following command:

```ruby index.rb```

A menu is displayed, allowing the user to select a category by typing the corresponding number and pressing enter.

```
Welcome to hangman!

Please choose a word category...
1. League of Legends
2. Half Life
3. Band Names
4. Basketball Players
5. Movie Titles
```

Once this selection is made, the user is presented with this dialogue and can press any key to begin the game.

```
I'm going to give you 8 chances
to guess letters in the League of Legends
themed word I'm thinking of.

Good luck!

Press any key to continue...
```

Guesses can be made by entering any character and then pressing enter. If the guess is not a previously guessed character and is not in the word, a life is lost. If it is in the word, that character is revealed wherever it appears in the word.

```
Your selected category is League of Legends

The word is: 
_ _ _ _ _ 

You have 8 lives left


Guess a letter...
```

If the player wins or loses, the user is prompted to either elect to play again or quit.

```
Sorry, you lose...

The word was RIVEN.

Play again? Y/N 
``` 

## Challenges

One of the major challenges was determining whether the user had won the game. This was solved by generating an array consisting of the common characters between the word and the guessed characters, then subtracting guessed characters from this array. If this returns an empty array, the win condition is met.

```
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
  ```

## To do

* Currently the entire game is contained within a single class - this isn't ideal. It would be best to separate the menu and continue/exit methods into a separate class.

* I have managed to exclude spaces from the characters the user needs to guess to win, but some words still include punctuation which I would prefer not to happen.
