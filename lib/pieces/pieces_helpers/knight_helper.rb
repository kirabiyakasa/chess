module KnightHelper

  private

  def knight_movement?(start_coords, coord_change, end_coords, spaces)
    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false if destination.color == @color
    end

    move_list = get_moves[:knight_moves]
    if move_list.include?(coord_change)
      return true
    end
    return false
  end

end
