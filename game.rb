
class Game

  require_relative 'player.rb'

  require 'yaml'

  attr_accessor :correct_letters, :incorrect_letters, :mistakes, :random_letter
  
  def initialize
    @correct_letters = []
    @incorrect_letters = []
    @fitting_words = []
    @random = pick_word
  end

  def intro
    puts "Welcome to hangman! Choose your name:"
    @player = Player.new(gets.chomp)
    
  end

  def pick_word
    File.readlines("5desk.txt").each do |i|
      i.length.between?(5,12) ? (@fitting_words << i.upcase) : next
    end
   @fitting_words[rand(@fitting_words.length)] 
  end

  def show_board
    
  end

  def play_round
    make_guess
    
  end

  def loop
    
  end
  
  def make_guess
    puts "Choose your letter:"
    chosen_letter = gets.chomp

    @random.each do |i|
      if i == chosen_letter
        @correct_letters << chosen_letter
      else
        @incorrect_letter << chosen_letter
        mistakes += 1
      end
      
    end
    
  end

end

play = Game.new
play.play_round
