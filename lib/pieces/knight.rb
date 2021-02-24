class Knight
  attr_reader :en_passant, :color, :icon

  def initialize(color)
    @color = color
    @icon = get_icon()
    @move_list =
    [
      [-2, 1], [-1, 2], [2, 1], [1, 2],
      [-2, -1], [-1, -2], [2, -1], [1, -2]
    ]
  end

  def get_icon()
    if @color == 'white'
      @icon = '♘'
    elsif @color == 'black'
      @icon = '♞'
    end
  end

end
