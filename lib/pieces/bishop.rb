class Bishop
  attr_reader :en_passant, :color, :icon
  
  def initialize(color)
    @color = color
    @icon = get_icon()
  end

  private

  def validate_move()
    # just check for diagonal
  end

  def diagonal_movement?(start_coords, coord_change, end_coords, spaces)
    destination = spaces[end_coords[0]][end_coords[1]]
    start_x = start_coords[0]
    start_y = start_coords[1]
    change_in_x = coord_change[0]
    change_in_y = coord_change[1]
  
    case change_in_x == change_in_y
    when change_in_x < start_x && change_in_y < start_y
      path = get_diagonal_moves([-1, -1], start_coords, end_coords, spaces)
    when change_in_x < start_x && change_in_y > start_y
      path = get_diagonal_moves([-1, 1], start_coords, end_coords, spaces)
    when change_in_x > start_x && change_in_y < start_y
      path = get_diagonal_moves([1, -1], start_coords, end_coords, spaces)
    when change_in_x > start_x && change_in_y > start_y
      path = get_diagonal_moves([1, 1], start_coords, end_coords, spaces)
    end
  
    path.each do |space|
      unless move == ' '
        return false
      end
    end
    unless destination == ' ' || destination.color == @color
      return true
    else
      return false
    end
  end
  
  def get_diagonal_moves(direction, start_coords, end_coords, spaces)
    path = []
    x = start_coords[0]
    y = start_coords[1]
  
    until x == end_coords[0] && y == end_coords[1]
      x += direction[0]
      y += direction[1]
      path << spaces[x][y]
    end
    path = path.pop
    return path
  end

  def get_icon()
    if @color == 'white'
      @icon = '♗'
    elsif @color == 'black'
      @icon = '♝'
    end
  end

end
