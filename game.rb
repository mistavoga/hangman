# coding: utf-8

class Game

  require_relative 'player.rb'

  require 'yaml'

  attr_accessor :correct_letters, :incorrect_letters, :mistakes, :random
  
  def initialize
    @correct_letters = []
    @incorrect_letters = []
    @fitting_words = Array.new
    @random = pick_word.split('')
    @mistakes = 0
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
    intro
    loop
  end

  def loop
    turn = 0
    while turn < 12
      make_guess
    end
  end
  
  def make_guess
    puts "Hello #{@player}. Choose your letter:"
    chosen_letter = gets.chomp.upcase

    unless chosen_letter.length == 1
      puts "Sorry, please type only one letter at the time"
    else
      @random.each do |i|
        if i == chosen_letter && chosen_letter.length == 1
          @correct_letters << chosen_letter
        elsif i != chosen_letter && chosen_letter.length == 1
          @incorrect_letters << chosen_letter
          @mistakes += 1
        end
      
      end
    end
  end

end

play = Game.new
play.play_round
