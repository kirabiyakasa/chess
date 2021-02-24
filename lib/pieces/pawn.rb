
require 'pry'

class Pawn
  include PiecesHelper

  attr_reader :en_passant, :color, :icon

  def initialize(color)
    @color = color
    @icon = get_icon()
    @en_passant = false
    @moved = false
  end

  private

  def validate_move(start_coords, end_coords, spaces, space)
    x = end_coords[0] - start_coords[0]
    y = end_coords[1] - start_coords[1]
    coord_change = [x, y]
    capture_coords = [end_coords[0], end_coords[1]]

    if space == ' '
      if vertical_movement?(coord_change, end_coords, spaces)
        return true
      elsif en_passant?(start_coords, coord_change, end_coords, spaces)
        @color == 'black' ? capture_coords[1] += 1 : capture_coords[1] -= 1
        capture(spaces, [end_coords[0], end_coords[1] - 1])
        return true
      end
    elsif diagonal_movement?(start_coords, coord_change, end_coords, spaces)
      capture(spaces, capture_coords)
      return true
    end
    return false
  end

  def vertical_movement?(coord_change, end_coords, spaces)
    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false
    end
    @color == 'black' ? valid_ranks = [-1, -2] : valid_ranks = [1, 2]

    if coord_change[1] == 0
      case coord_change[0]
      when valid_ranks[0]
        @moved = true
        @en_passant = false
        return true
      when valid_ranks[1]
        if @moved == false
          @moved = true
          @en_passant = true
          return true
        end
      end
    end
    return false
  end

  def diagonal_movement?(start_coords, coord_change, end_coords, spaces)
    destination = spaces[end_coords[0]][end_coords[1]]
    if destination == ' ' || destination.color == @color
      return false
    end
    change_in_rank = coord_change[0]
    change_in_file = coord_change[1]
    @color == 'black' ? valid_file = -1 : valid_file = 1

    if change_in_rank == -1 || change_in_rank == 1
      if change_in_file == valid_file
        @moved = true
        @en_passant = false
        return true
      end
    end
    return false
  end
  # if the change in y is lesser than the starting point
  # the bishop moved down
  # if the change in y is greater than the starting point
  # the bishop moved up
  # if the change in x is lesser than the start point
  # the bishop moved left
  # if the change in x is greater than the start point
  # the bishop moved right

  def en_passant?(start_coords, coord_change, end_coords, spaces)
    opposing_piece = spaces[end_coords[0] - coord_change[0]][end_coords[1]]
    if opposing_piece == ' ' || opposing_piece.color == @color
      return false
    elsif coord_change[0] > 1 || coord_change[0] < -1
      return false
    end
  
    unless opposing_piece.en_passant == false
      case start_coords[0]
      when 3
        if @color == 'black' && coord_change[0] == -1
          return true
        end
      when 4
        if @color == 'white' && coord_change[0] == 1
          return true
        end
      end
    end
    return false
  end

  def get_icon()
    if @color == 'white'
      @icon = '♙'
    elsif @color == 'black'
      @icon = '♟︎'
    end
  end

end
