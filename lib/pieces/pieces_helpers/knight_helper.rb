module KnightHelper

  private

  def knight_movement?(start_coords, coord_diff, end_coords, spaces)
    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false if destination.color == @color
    end

    if @move_list.include?(coord_diff)
      return true
    end
    return false
  end

end
