class Card
  
  SYM = (:a..:z).to_a 
  attr_reader :face_value, :face_pos
  
  def initialize(face_value=nil, face_pos=nil)
    @face_value, @face_pos = face_value, face_pos
  end 
  
  def hide
    @face_pos = false
  end
  
  def reveal
    @face_pos = true
  end
  
  def to_s
    @face_value.to_s
  end 
  
  def ==(card)
    @face_value == card.face_value
  end 
  
end 

class Board
  
  attr_reader :grid, :size
  
  def initialize(size = 2)
    @grid = Array.new(size) { Array.new(size, nil) }
    @size = size
    self.populate
  end 
  
  def populate
    num_symbols = (@size * @size / 2)
    symbols_arr = (Card::SYM[0...num_symbols] * 2).shuffle
    # (0...@size).to_a.permutation(2) do |pos|
    #   self[pos] = Card.new(symbols_arr.pop, true)
    # end
    
    @grid.each_with_index do |row,idx|
      row.each_with_index do |value, idx2|
        self[[idx,idx2]] = Card.new(symbols_arr.pop, true)
      end
    end
    
  end 
  
  def [](pos)
    x,y=pos
    @grid[x][y]
  end
  
  def []=(pos,value)
    x,y=pos
    @grid[x][y]=value
  end
  
  def empty?(pos)
    self[pos].nil?
  end
  
  def full?
    @grid.flatten.none? { |pos| pos.nil? }
  end
  
  def render
    #display grid
    
    @grid.each do | row |
      parse_row = row.map do | card |
        if card.face_pos
          card.face_value.to_s
        else
          "*"
        end
      end
      puts parse_row.join(" ")
    end
    
  end 
  
  def won?
    @grid.flatten.all? { |card| card.face_pos}
  end
  
  def reveal(pos)
    self[pos].reveal
  end
  
  def hide_all
    @grid.flatten.each { |card| card.hide }
  end 
  
end 

class Game 
  
  attr_accessor :previous_guess, :current_guess, :board
  
  def initialize(board,player)
    @board = board 
    @player = player
    @counter = 1
  end 
  
  def setup
    
    @board.render
    sleep(3)
    system("clear")
    @board.hide_all
  end
  
  def play
    setup
    
    until over? 
      play_turn 
    end 
    system("clear")
    @board.render
    puts "winner!"
  end
  
  def play_turn 
    @player.player_update(@board)
    
    guess = @player.prompt(@counter)
    guess = validate_guess(guess)
    @previous_guess = parse_guess(guess)
    @board[@previous_guess].reveal
    @player.player_update(@board)
    @counter +=1
  
    guess2 = @player.prompt(@counter)
    guess2 = validate_guess(guess2)
    @current_guess = parse_guess(guess2)
    @board[@current_guess].reveal
    
    unless guessed_pos?
      @player.player_update(@board)
      sleep(3)
      @board[@previous_guess].hide
      @board[@current_guess].hide
    end
    @counter -= 1 
  end
  
  def guessed_pos?
    @board[@previous_guess] == @board[@current_guess]
  end
  
  def over?
    @board.won? 
  end
  
  def valid_guess?(string)
    pos = string.split(",")
    pos.map! do |x|
      return false unless ("0".."9").include?(x)
      x.to_i
    end
    if pos[0] >= @board.size || pos[1] >= @board.size
      return false
    end
      # return false unless @board[pos]
    return false if @board[pos].face_pos
    true
  end 
  
  def parse_guess(string)
    pos = string.split(",")
    pos.map!{|x| x.to_i}
  end
  
  def validate_guess(guess)
    new_guess = guess
    until valid_guess?(new_guess)
      print "Try again: "
      new_guess = @player.prompt(@counter)
    end
    new_guess
  end
  
end 

class Player
  
  def initialize(board = nil)
    @board = board.dup
  end
  
  def prompt(num=nil)
    print "Choose card #{num} (ex: row,col ) "
    get_input
  end
  
  def get_input
    gets.chomp 
  end
  
  def player_update(board)
    system("clear")
    board.render 
  end
end


class AI
  
  def initialize(board)
    @board = board.grid.dup
    @positions = []
    symbols = @board.flatten.map { |card| card.face_value }
    symbols.uniq!
    @locations = Hash.new{|h,k| h[k] = Array.new()}
    @previous_guess = nil
    populate_positions
  end 
  
  def populate_positions
    (0...@board.size).each do |idx|
      (0...@board.size).each do |idx2|
        @positions << [idx,idx2]
      end
    end
  end
  
  def prompt(num)
    print "Choose card #{num} (ex: row,col ) "
    choice = get_input.join(",")
    puts "Computer chooses #{choice}\n"
    return choice
  end
  
  def player_update(board)
    
    @board = board.grid.dup
    @board.each_with_index do |row,idx|
      row.each_with_index do |card,idx2|
        next unless card.face_pos
        symbols = card.face_value
        @locations[symbols] << [idx,idx2] unless @locations[symbols].include?([idx,idx2])
      end
    end
    system("clear")
    board.render
  end
  
  def get_input
      matches = @locations.select{ |sym,pos| pos.count == 2}
      unless matches.empty?
        if @previous_guess.nil?
          guess = matches.keys.first
          @previous_guess = guess
          return @locations[guess][0]
        else
          guess = @previous_guess
          @previous_guess = nil
          pos =  @locations[guess][1]
          pos2 = @locations[guess][0]
          @locations[guess] << []
          @positions.delete(pos)
          @positions.delete(pos2)
          return pos
        end
      end
      @positions.sample
  end

end
  
if __FILE__ == $PROGRAM_NAME
  board = Board.new(4)
  player = Player.new()
  ai = AI.new(board)
  puts "Computer? y/n"
  answer = gets.chomp
  if answer == "y"
    game = Game.new(board, ai)
  elsif answer == "n"
    game = Game.new(board,player)
  end
  card = Card.new()
  card1 = Card.new()
  game.play
  
end