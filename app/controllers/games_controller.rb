require "open-uri"

class GamesController < ApplicationController

  def new
    letters = ('A'..'Z').to_a
    @array_letters = Array.new(10) { letters[rand(26)] }
  end

  def score
    @my_word = params[:word]
    @letters = params[:letters]
    if is_english?(@my_word) == false
      @message = "Sorry but #{@my_word} does not seem to be a valid English word..."
    elsif letter_include?(@my_word, @letters) == false
      @message = "Sorry but #{@my_word} can't be built out of #{@letters}"
    elsif is_english?(@my_word) && letter_include?(@my_word, @letters)
      @message = "Congratulations!#{@my_word}is a valid English word!"
    end
  end

  private

  def is_english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    respons = URI.open(url).read
    JSON.parse(respons)["found"]
  end

  def letter_include?(word, letters)
    # Utilisation de la méthode include? pour vérifier si la lettre est incluse dans le mot
    word.chars do |letter|
      if letters.include?(letter)
        letters.chars.delete_at(letters.index(letter))
      else
        return false
      end
    end
    return true
  end

end
# && letter_include?(params[:letters])
