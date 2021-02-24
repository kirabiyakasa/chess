class Queen
  attr_reader :en_passant, :color, :icon

  def initialize(color)
    @color = color
    @icon = get_icon()
  end

  def get_icon()
    if @color == 'white'
      @icon = '♕'
    elsif @color == 'black'
      @icon = '♛'
    end
  end

end
