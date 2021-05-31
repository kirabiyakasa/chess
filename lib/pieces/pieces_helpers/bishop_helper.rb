module BishopHelper

  private

  def diagonal_movement?(start_coords, coord_change, end_coords, spaces)
    unless coord_change[0].abs == coord_change[1].abs
      return false
    end
  
    direction = []
    coord_change[0].positive? ? direction << 1 : direction << -1
    coord_change[1].positive? ? direction << 1 : direction << -1
    path = get_diagonal_moves(direction, start_coords, end_coords, spaces)
    
    return false if path.empty?
  
    destination = path.pop
    unless destination == ' '
      return false if destination.color == @color
    end
  
    path.each do |space|
      if space != ' '
        return false
      end
    end
    return true
  end
  
  def get_diagonal_moves(direction, start_coords, end_coords, spaces)
    path = []
    file = start_coords[0]
    rank = start_coords[1]
  
    until file == end_coords[0] && rank == end_coords[1]
      file += direction[0]
      rank += direction[1]
      path << spaces[file][rank]
    end
    return path
  end

end
