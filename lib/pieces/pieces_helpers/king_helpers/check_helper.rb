module CheckHelper

  def checked_vertically_or_horizontally?(king_coords, spaces)
    vert_horiz_directions = get_moves[:rook_moves]
    pieces = []

    vert_horiz_directions.each do |direction|
      pieces << get_vert_horiz_piece(king_coords, direction, spaces)
    end

    pieces.each do |piece|
      unless piece == nil || piece.color == @color
        if piece.class.name == 'Rook' || piece.class.name == 'Queen'
          @checked_by << piece
        end
      end
    end
  end

  def get_vert_horiz_piece(piece_coords, direction, spaces)
    file = piece_coords[0] + direction[0]
    rank = piece_coords[1] + direction[1]

    until spaces[file] == nil || spaces[file][rank] != ' ' || rank < 0
      file += direction[0]
      rank += direction[1]
    end

    unless spaces[file] == nil || rank < 0
      return spaces[file][rank]
    else
      return nil
    end
  end

  def checked_diagonally?(piece_coords, spaces)
    diag_directions = get_moves[:bishop_moves]
    pieces = []

    diag_directions.each do |direction|
      pieces << get_diagonal_piece(piece_coords, direction, spaces)
    end

    pieces.each do |piece|
      unless piece == nil || piece.color == @color
        if ['Bishop', 'Queen', 'Pawn'].include?(piece.class.name)
          @checked_by << piece
        end
      end
    end
  end

  def get_diagonal_piece(king_coords, direction, spaces)
    file = king_coords[0] + direction[0]
    rank = king_coords[1] + direction[1]

    until spaces[file] == nil || spaces[file][rank] != ' ' || rank < 0
      file += direction[0]
      rank += direction[1]
    end

    unless spaces[file] == nil || rank < 0
      if spaces[file][rank].class.name == 'Pawn'
        return checked_by_pawn?(king_coords, [file, rank], spaces)
      else
        return spaces[file][rank]
      end
    else
      return nil
    end
  end

  def checked_by_pawn?(king_coords, pawn_coords, spaces)
    unless (king_coords[0] - pawn_coords[0]).abs == 1
      return nil
    end

    pawn = spaces[pawn_coords[0]][pawn_coords[1]]

    if @color == 'white'
      unless pawn_coords[1] > king_coords[1]
        return nil
      end
    elsif @color == 'black'
      unless pawn_coords[1] < king_coords[1]
        return nil
      end
    else
      return nil
    end
    return pawn
  end

  def checked_by_knight?(king_coords, spaces)
    knight_moves = get_moves[:knight_moves]
    pieces = []

    knight_moves.each do |move|
      pieces << get_knight(king_coords, move, spaces)
    end

    pieces.each do |piece|
      unless piece == nil || piece.color == @color
        if piece.class.name == 'Knight'
          @checked_by << piece
        end
      end
    end
  end

  def get_knight(king_coords, move, spaces)
    file = king_coords[0] + move[0]
    rank = king_coords[1] + move[1]

    unless spaces[file] == nil || rank < 0
      if spaces[file][rank].class.name == 'Knight'
        return spaces[file][rank]
      else
        return nil
      end
    end
  end

end
