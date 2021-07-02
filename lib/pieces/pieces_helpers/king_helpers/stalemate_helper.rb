module StalemateHelper
  def moveable_pieces?(king_coords, available_pieces, board)
    available_pieces.each do |piece|
      moveability = get_moveability(king_coords, available_pieces, board, piece)
      return true if moveability == true
    end
    return false
  end
  
  def get_moveability(king_coords, available_pieces, board, piece)
    moveable_pieces = []
    ally_moves = get_moves()
  
    ally_moves.each do |move_type, move_set|
      move_set.each do |move_coords|
  
        case piece.class.name
        when 'Rook'
          if moveable_rook?(king_coords, move_type, piece, move_coords, board)
            return true
          end
        when 'Bishop'
          if moveable_bishop?(king_coords, move_type, piece, move_coords, board)
            return true
          end
        when 'Knight'
          if moveable_knight?(king_coords, move_type, piece, move_coords, board)
            return true
          end
        when 'Pawn'
          if moveable_pawn?(king_coords, move_type, piece, move_coords, board)
            return true
          end
        when 'Queen'
          if moveable_queen?(king_coords, move_type, piece, move_coords, board)
            return true
          end
        end
      end
    end
    return false
  end

  def moveable_queen?(king_coords, move_type, piece, move_coords, board)
    path = false
    if move_type == :rook_moves
      path = moveable_rook?(king_coords, move_type, piece, move_coords, board)
    elsif move_type == :bishop_moves
      path = moveable_bishop?(king_coords, move_type, piece, move_coords, board)
    end

    if path == false
      return false
    else
      return true
    end
  end

  def moveable_rook?(king_coords, move_type, piece, move_coords, board)
    if move_type == :rook_moves
      path = get_rook_or_bishop_paths(piece, move_coords, board)
      path.each do |ally_coords|
        move = get_legal_vert_horiz_moves([king_coords, ally_coords],
                                          board, piece)
        unless move == nil
          return true
        end
      end
    end
    return false
  end

  def moveable_bishop?(king_coords, move_type, piece, move_coords, board)
    if move_type == :bishop_moves
      path = get_rook_or_bishop_paths(piece, move_coords, board)
      path.each do |ally_coords|
        move = get_legal_diag_moves([king_coords, ally_coords], board, piece)
        unless move == nil
          return true
        end
      end
    end
    return false
  end

  def moveable_knight?(king_coords, move_type, piece, move_coords, board)
    if move_type == :rook_moves
      path = get_knight_paths(piece, move_coords, board)
      unless path == nil
        move = get_legal_knight_moves([king_coords, path], board, piece)
      end

      unless move == nil
        return true
      end
    end
    return false
  end

  def moveable_pawn?(king_coords, move_type, piece, move_coords, board)
    if move_type == :pawn_moves
      path = get_pawn_paths(piece, move_coords, board)
      unless path == nil
        move = get_legal_pawn_moves(king_coords, path, move_coords, board.spaces)
        unless move == nil
          return true
        end
      end
    end
    return false
  end

  def get_pawn_paths(piece, move_coords, board)
    piece_coords = board.get_piece_coords(piece)
    spaces = board.spaces

    file = piece_coords[0] + move_coords[0]
    rank = piece_coords[1] + move_coords[1]

    unless spaces[file] == nil || spaces[file][rank] == nil
      return [file, rank]
    end
    return nil
  end
  
  def get_rook_or_bishop_paths(piece, move_coords, board)
    path = []
    piece_coords = board.get_piece_coords(piece)
    spaces = board.spaces
  
    file = piece_coords[0] + move_coords[0]
    rank = piece_coords[1] + move_coords[1]

    until spaces[file] == nil || spaces[file][rank] != ' '
      file += move_coords[0]
      rank += move_coords[1]
    end
    unless spaces[file] == nil || spaces[file][rank] == nil
      space = spaces[file][rank]
      unless space.color == @color
        path << [file, rank]
      end
    end
    return path
  end

  def get_knight_paths(piece, move_coords, board)
    piece_coords = board.get_piece_coords(piece)
    spaces = board.spaces

    file = piece_coords[0] + move_coords[0]
    rank = piece_coords[1] + move_coords[1]
    
    unless spaces[file] == nil || spaces[file][rank] == nil
      space = spaces[file][rank]
      if space == ' ' || space.color != @color
        return [file, rank]
      end
    end
    return nil
  end
  
  def get_pawn_paths1(piece, move_coords, board)
    path = []
    destination == nil
    piece_coords = board.get_piece_coords(piece)
    spaces = board.spaces

    file = piece_coords[0] + move_coords[0]
    rank = piece_coords[1] + move_coords[1]

    unless spaces[file] == nil
      destination = spaces[file][rank]
      return nil if destination == nil
    end

    if (move_coords[0] == 0 && destination == ' ' ||
        move_coords[0] != 0 && destination != ' ')
      unless move_coords[0] != 0 && destination.color == @color
        path << [file, rank]
      end
    end
    return path
  end
end
