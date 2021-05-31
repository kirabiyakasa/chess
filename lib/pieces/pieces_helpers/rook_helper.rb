module RookHelper

  private

  def vertical_movement?(start_coords, coord_change, end_coords, spaces)
    return false if coord_change[1] == 0
    unless coord_change[0] == 0
      return false
    end

    coord_change[1].positive? ? direction = [0, 1] : direction = [0, -1]

    path = get_horiz_vert_moves(direction, start_coords, end_coords, spaces)
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

  def horizontal_movement?(start_coords, coord_change, end_coords, spaces)
    return false if coord_change[0] == 0
    unless coord_change[1] == 0
      return false
    end

    coord_change[0].positive? ? direction = [1, 0] : direction = [-1, 0]

    path = get_horiz_vert_moves(direction, start_coords, end_coords, spaces)
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

  def get_horiz_vert_moves(direction, start_coords, end_coords, spaces)
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

  def get_icon()
    if @color == 'white'
      @icon = '♖'
    elsif @color == 'black'
      @icon = '♜'
    end
  end

end