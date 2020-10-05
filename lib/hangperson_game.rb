class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  # attr_accessor :word
  # attr_accessor :wrong_guesses
  # attr_accessor :guesses
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  def guess(letter)

    #invalid guess
    raise ArgumentError if letter.nil? || letter.empty? || letter.match(/[^A-Za-z]|..+/)

    #valid guess
    letter.downcase!

    if (@guesses.include? letter) || (@wrong_guesses.include? letter)
      return false
    else
      if @word.include? letter
        @guesses << letter
      else
        @wrong_guesses << letter

      end
    end
  end

  def word_with_guesses
    r = ''
    @word.split('').each do |letter|
      #puts letter

      if(@guesses.include? letter)
        r << letter
      else
        r << '-'
      end
    end
    #  puts r
    return r
  end
  def check_win_or_lose
    if self.word_with_guesses == @word
      return :win
      elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end
end
