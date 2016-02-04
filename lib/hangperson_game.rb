class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :guesses, :wrong_guesses, :word
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(char)
    raise ArgumentError,"Please input letters only" unless char =~ /[A-Za-z]/
    if not @guesses.upcase.include? char.upcase and not @wrong_guesses.upcase.include? char.upcase
      if word.include? char
        @guesses << char
      else
        @wrong_guesses << char
      end
      return true
    end
    return false
  end
  
  def check_win_or_lose
    if @wrong_guesses.length + @guesses.length < 7
      if not word_with_guesses.include? '-'
        return :win
      else
        return :play
      end
    else
      return :lose
    end
  end
    
  def word_with_guesses
    progress = '-'*@word.length
    temp = (0..@word.length-1).each {|i| progress[i] = @word[i] if guesses.include? @word[i]}
    return progress
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
