class Tile
  attr_reader :value, :given
  
  def initialize(value,given = false)
    @value = value
    @given = given
  end
  
  def to_s
    @value.to_s
  end
  
end

class Board
  
  attr_accessor :grid
  
  def self.from_file(filename)
    grid = []
    File.foreach(filename) do |row|
      symbols = row.chars.map(&:to_sym)
      tiles = symbols.map do |symbol|
        given = true 
        given = false if symbol == :0 
        tile = Tile.new(symbol, given)
      end 
      grid << tiles 
    end
    Board.new(grid)
  end
  
  def initialize(grid)
    @grid = grid
  end
  
  def [](pos)
    x,y = pos
    @grid[x][y] 
  end 
  
  def []=(pos, tile)
    x,y = pos
    @grid[x][y] = tile 
  end
  
  def update_tile(pos, tile)
    self[pos] = tile
  end
  
  def render
    @grid.each do | row |
      parse_row = row.map do | tile |
        if tile.given
          tile.value.to_s
        else
          "_"
        end
      end
      puts parse_row.join(" ")
    end
  end 
  
  def solved? 
    return false unless @grid.all? do |row| 
      row.map{ |tile| tile.value.to_i }.reduce(:+) == 45 
    end 
    
    return false unless @grid.tranpose.all? do |row|
      row.map{ |tile| tile.value.to_i }.reduce(:+) == 45 
    end 
    
    
    # quandrant solution i have no more brain power
    true 
  end 
end

class Game
  
end