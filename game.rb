# coding: utf-8

class Game
  require_relative "player.rb"

  require "yaml"

  attr_accessor :correct_letters, :incorrect_letters, :mistakes, :random, :bool

  def initialize
    @correct_letters = []
    @incorrect_letters = []
    @fitting_words = []
    @random = pick_word.split("")
    @mistakes = 0
    @bool = false
  end

  def intro
    puts "Welcome to hangman! Choose your name:"
    @player = Player.new(gets.chomp)
  end

  def serialize_game
    Dir.mkdir("saved") unless Dir.exist? "saved"
    puts "How should the saved_state be called?"
    filename = gets.chomp
    File.open("saved/#{filename}.yml", "w") do |serialize|
      game = (YAML::dump({
        player: @player,
        correct_letters: @correct_letters,
        incorrect_letters: @incorrect_letters,
        random: @random,
        mistakes: @mistakes,
        bool: @bool,
      }))
      serialize.puts game
    end
  end

  def load_game
    puts "Type the name of the file you want to load:"
    answer = gets.chomp
    if File.exist? "saved/#{answer}.yml"
      saved_game = YAML::load File.read("saved/#{answer}.yml")
      @player = saved_game[:player]
      @correct_letters = saved_game[:correct_letters]
      @incorrect_letters = saved_game[:incorrect_letters]
      @mistakes = saved_game[:mistakes]
      @bool = saved_game[:bool]
      @random = saved_game[:random]
    else puts "Sorry, unfortunately this file doesnt exist."     end
  end

  def pick_word
    File.readlines("5desk.txt").each do |i|
      i.strip!.size.between?(5, 12) ? (@fitting_words << i.upcase) : next
    end
    @fitting_words[rand(@fitting_words.size)]
  end

  def show_board
    puts " ---+---+---+---+---"
    @random.each do |i|
      if @correct_letters.include?(i)
        puts i
      else
        puts "_"
      end
    end
    puts "---+---+---+---+---"
    puts "Your mistake count: #{@mistakes}"
    puts "Your wrong letters:#{@incorrect_letters.join("-")}"
    puts "---+---+---+---+---"
  end

  def play_round
    loop
  end

  def loop
    puts " Do you want to load an existing game (admit with y)?"
    answer = gets.chomp
    if answer == "y"
      load_game
    else
      intro
    end
    while @mistakes < 12
      make_guess
      show_board
      puts "Do you want to save your game? (admit with y)"
      answer = gets.chomp
      if answer == "y"
        serialize_game
        break
      else
        next
      end
    end
    puts "Unfortunately, you wasn't able to guess the right word" if @mistakes == 12
  end

  def make_guess
    @bool == false ? (puts "Hello #{@player}! Choose your letter:") : (puts "Choose your letter:")
    chosen_letter = gets.chomp.capitalize
    @bool = true

    unless chosen_letter.size == 1
      puts "Sorry, please type one letter at the time"
    else
      if @random.any?(chosen_letter)
        @correct_letters << chosen_letter
      elsif @incorrect_letters.any?(chosen_letter)
        puts "You already took this letter"
      else
        @incorrect_letters << chosen_letter
        @mistakes += 1
      end
    end
  end
end

play = Game.new
play.loop
