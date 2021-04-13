require 'pry'

require './lib/pieces/pieces_helper'

require './lib/pieces/bishop.rb'
require './lib/pieces/king.rb'
require './lib/pieces/knight.rb'
require './lib/pieces/pawn.rb'
require './lib/pieces/queen.rb'
require './lib/pieces/rook.rb'

class BoardBuilder

  def build_board()
    white_pieces = get_pieces('white')
    black_pieces = get_pieces('black')
  
    black_row1 = get_initial_row(black_pieces)
    white_row1 = get_initial_row(white_pieces)
    black_row2 = black_pieces[:pawn]
    white_row2 = white_pieces[:pawn]
  
    spaces =
    {
      0 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      1 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      2 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      3 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      4 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      5 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      6 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      7 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    }
  
    spaces.keys.each do |file|
      spaces[file][0] = white_row1.shift
      spaces[file][1] = white_row2.shift
      spaces[file][6] = black_row2.shift
      spaces[file][7] = black_row1.shift
    end
    return spaces
  end

  def build_board_old()
    white_pieces = get_pieces('white')
    black_pieces = get_pieces('black')

    black_row1 = get_initial_row(black_pieces)
    white_row1 = get_initial_row(white_pieces)
    black_row2 = black_pieces[:pawn]
    white_row2 = white_pieces[:pawn]
  
    spaces =
    {
      7 => black_row1,
      6 => black_row2,
      5 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      4 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      3 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      2 => [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
      1 => white_row2,
      0 => white_row1
    }
    return spaces
  end

  private

  def get_pieces(color)
    pieces = {}
    pieces[:king] = King.new(color)
    pieces[:queen] = Queen.new(color)
    pieces[:bishop] = []
    pieces[:knight] = []
    pieces[:rook] = []
    pieces[:pawn] = []
    2.times do
      pieces[:bishop] << Bishop.new(color)
      pieces[:knight] << Knight.new(color)
      pieces[:rook] << Rook.new(color)
    end
    8.times do
      pieces[:pawn] << Pawn.new(color)
    end
    return pieces
  end
  
  def get_initial_row(pieces)
    initial_row = []
    initial_row << pieces[:queen]
    initial_row << pieces[:king]
    initial_row_pieces = [pieces[:bishop], pieces[:knight], pieces[:rook]]

    initial_row_pieces.each do |piece_set|
      initial_row.unshift(piece_set[0])
      initial_row.push(piece_set[1])
    end
    return initial_row
  end

end