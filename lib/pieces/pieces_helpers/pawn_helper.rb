module PawnHelper

  private

  def vertical_movement?(coord_change, end_coords, spaces)
    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false
    end
    @color == 'black' ? valid_ranks = [-1, -2] : valid_ranks = [1, 2]

    if coord_change[0] == 0
      case coord_change[1]
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
    change_in_file = coord_change[0]
    change_in_rank = coord_change[1]
    @color == 'black' ? valid_rank = -1 : valid_rank = 1

    if change_in_file == -1 || change_in_file == 1
      if change_in_rank == valid_rank
        @moved = true
        @en_passant = false
        return true
      end
    end
    return false
  end

  def en_passant?(start_coords, coord_change, end_coords, spaces)
    opposing_piece = spaces[end_coords[0]][end_coords[1] - coord_change[1]]
    if opposing_piece == ' ' || opposing_piece.color == @color
      return false
    elsif coord_change[1] > 1 || coord_change[1] < -1
      return false
    end
  
    unless opposing_piece.en_passant == false
      case start_coords[1]
      when 3
        if @color == 'black' && coord_change[1] == -1
          return true
        end
      when 4
        if @color == 'white' && coord_change[1] == 1
          return true
        end
      end
    end
    return false
  end

end