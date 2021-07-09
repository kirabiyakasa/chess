module RookHelper

  def get_horiz_vert_moves(coord_change, start_coords, end_coords, spaces)
    if coord_change[1].positive? || coord_change[1].negative?
      coord_change[1].positive? ? direction = [0, 1] : direction = [0, -1]
    else
      coord_change[0].positive? ? direction = [1, 0] : direction = [-1, 0]
    end

    path = []
    file = start_coords[0]
    rank = start_coords[1]
    
    until file == end_coords[0] && rank == end_coords[1]
      file += direction[0]
      rank += direction[1]
      path << [file, rank]
    end
    return path
  end

  private

  def vertical_movement?(start_coords, coord_change, end_coords, spaces)
    return false if coord_change[1] == 0
    unless coord_change[0] == 0
      return false
    end

    path = get_horiz_vert_moves(coord_change, start_coords, end_coords, spaces)
    return false if path.empty?

    path.pop
    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false if destination.color == @color
    end

    path.each do |coords|
      if spaces[coords[0]][coords[1]] != ' '
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

    path = get_horiz_vert_moves(coord_change, start_coords, end_coords, spaces)
    return false if path.empty?

    path.pop
    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false if destination.color == @color
    end

    path.each do |coords|
      if spaces[coords[0]][coords[1]] != ' '
        return false
      end
    end
    return true
  end

  def get_icon()
    if @color == 'white'
      @icon = '♖'
    elsif @color == 'black'
      @icon = '♜'
    end
  end

end
