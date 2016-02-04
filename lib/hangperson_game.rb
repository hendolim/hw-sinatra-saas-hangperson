class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :guesses, :wrong_guesses, :word, :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * @word.length
  end
  
  def guess(char)
    raise ArgumentError,"Please input letters only" unless char =~ /[A-Za-z]/
    if not @guesses.upcase.include? char.upcase and not @wrong_guesses.upcase.include? char.upcase
      if word.include? char
        @guesses << char
        temp = (0..@word.length-1).find_all {|i| @word[i,1]==char}
        temp.each {|i| @word_with_guesses[i] = char}
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
    
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
