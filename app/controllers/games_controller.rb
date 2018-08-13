require 'json'
require 'open-uri'
require 'pry'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @user_guess = params[:guess]
    @random_letters = params[:letters].split(' ')
    url = "https://wagon-dictionary.herokuapp.com/#{params[:guess]}"
    user_serialized = open(url).read
    json_file = JSON.parse(user_serialized)
    @word_check = json_file['found']
    @bingo = included?(@user_guess, @random_letters)
  end

private

  # def checking(word)
  #   letters_grid = @array.split(' ')
  #   word.upcase.chars.each do |letter|
  #     if letters_grid.include?(letter)
  #       letter_index = letters_grid.index(letter)
  #       letters_grid.delete_at(letter_index)
  #     else
  #       return false
  #     end
  #   end
  #   return true
  # end

  def included?(guess, grid)
    guess.upcase.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
