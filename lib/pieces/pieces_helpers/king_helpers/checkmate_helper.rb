require 'pry'

module CheckmateHelper

  def mock_move(king_coords, piece_coords, piece_move, spaces)
    return false if king_coords == piece_coords
    move_legality = false

    piece_coords == nil ? file = king_coords[0] : file = piece_coords[0]
    piece_coords == nil ? rank = king_coords[1] : rank = piece_coords[1]

    destination = spaces[piece_move[0]][piece_move[1]]
    piece = spaces[file][rank]
    return false if piece_move[1].negative?
    spaces[file][rank] = ' '
    spaces[piece_move[0]][piece_move[1]] = piece

    if piece_coords == nil
      updated_king_coords = [piece_move[0], piece_move[1]]
    else
      updated_king_coords = king_coords
    end

    unless checked?(updated_king_coords, spaces)
      move_legality = true
    end

    spaces[file][rank] = piece
    spaces[piece_move[0]][piece_move[1]] = destination
    checked?(king_coords, spaces)

    return move_legality
  end

  private

  def get_check_paths(king_coords, spaces, board)
    paths = []

    @checked_by.each do |piece|
      piece_coords = board.get_piece_coords(piece)

      file = king_coords[0] - piece_coords[0]
      rank = king_coords[1] - piece_coords[1]
      coord_change = [file, rank]

      if piece.class.name == 'Bishop' || piece.class.name == 'Queen'
        unless coord_change[0] == 0 || coord_change[1] == 0
          path = piece.get_diagonal_moves(coord_change, piece_coords,
                                          king_coords, spaces)
          paths += [piece_coords] + path
        end
      end

      if piece.class.name == 'Rook' || piece.class.name == 'Queen'
        if coord_change[0] == 0 || coord_change[1] == 0
          path = piece.get_horiz_vert_moves(coord_change, piece_coords,
                                            king_coords, spaces)
          paths += [piece_coords] + path
        end
      elsif piece.class.name == 'Knight'
        paths += [piece_coords] + [king_coords]
      elsif piece.class.name == 'Pawn'
        paths += [piece_coords] + [king_coords]
      end
    end
    return paths.uniq
  end

  def get_legal_king_moves(king_coords, king_moves, board, enemy_paths)
    spaces = board.spaces
    legal_king_moves = []

    king_moves.each do |move|
      file = king_coords[0] + move[0]
      rank = king_coords[1] + move[1]
      unless spaces[file] == nil
        return legal_king_moves if rank.negative?
        space = spaces[file][rank]
        return legal_king_moves if space == nil

        if space == ' '
          unless enemy_paths.include?([file, rank])
            if mock_move(king_coords, nil, [file, rank], spaces)
              legal_king_moves << [file, rank]
            end
          end
        elsif space.color != @color
          if mock_move(king_coords, nil, [file, rank], spaces)
            legal_king_moves << [file, rank]
          end
        end
      end
    end
    return legal_king_moves
  end

  def get_legal_move_list(king_coords, board, enemy_paths)
    legal_moves = []

    enemy_paths.each do |enemy_coords|
      legal_moves += get_legal_moves(king_coords, board, enemy_coords)
    end
    return legal_moves
  end

  def get_legal_moves(king_coords, board, end_coords)
    spaces = board.spaces
    ally_moves = get_moves()
    legal_moves = []

    ally_moves.each do |move_type, move_set|
      move_set.each do |move_coords|

        case move_type
        when :rook_moves
          piece = get_vert_horiz_piece(end_coords, move_coords, spaces)
          legal_move = get_legal_vert_horiz_moves([king_coords, end_coords],
                                                   board, piece)
          legal_move == nil ? nil : legal_moves << legal_move
        when :bishop_moves
          piece = get_diagonal_piece(end_coords, move_coords, spaces)
          legal_move = get_legal_diag_moves([king_coords, end_coords],
                                             board, piece)
          legal_move == nil ? nil : legal_moves << legal_move
        when :knight_moves
          piece = get_knight(end_coords, move_coords, spaces)
          legal_move = get_legal_knight_moves([king_coords, end_coords],
                                               board, piece)
          legal_move == nil ? nil : legal_moves << legal_move
        when :pawn_moves
          legal_move = get_legal_pawn_moves(king_coords, end_coords,
                                            move_coords, spaces)
          legal_move == nil ? nil : legal_moves << legal_move
        end
      end
    end
    return legal_moves
  end

  def get_legal_vert_horiz_moves(coords, board, piece)
    king_coords = coords[0]
    end_coords = coords[1]

    spaces = board.spaces
    piece_coords = board.get_piece_coords(piece)

    if piece != nil && piece.color == @color
      if mock_move(king_coords, piece_coords, end_coords, spaces)
        if piece.class.name == 'Rook' || piece.class.name == 'Queen'
          return piece_coords
        else
          return nil
        end
      end
    end
    return nil
  end

  def get_legal_diag_moves(coords, board, piece)
    king_coords = coords[0]
    end_coords = coords[1]

    spaces = board.spaces
    piece_coords = board.get_piece_coords(piece)

    if piece != nil && piece.color == @color
      if mock_move(king_coords, piece_coords, end_coords, spaces)
        if piece.class.name == 'Bishop' || piece.class.name == 'Queen'
          return piece_coords
        else
          return nil
        end
      end
    end
    return nil
  end

  def get_legal_knight_moves(coords, board, piece)
    king_coords = coords[0]
    end_coords = coords[1]

    spaces = board.spaces
    piece_coords = board.get_piece_coords(piece)

    if mock_move(king_coords, piece_coords, end_coords, spaces)
      if piece.class.name == 'Knight'
        return piece_coords
      else
        return nil
      end
    end
    return nil
  end

  def get_legal_pawn_moves(king_coords, destination, move_coords, spaces)
    ally_piece = nil
    piece_coords = []
    piece_coords << destination[0] - move_coords[0]
    piece_coords << destination[1] - move_coords[1]

    unless spaces[piece_coords[0]] == nil
      ally_piece = spaces[piece_coords[0]][piece_coords[1]]
      return nil if ally_piece == nil || ally_piece.class.name != 'Pawn'
    end

    file = destination[0]
    rank = destination[1]

    if (move_coords[0] == 0 && spaces[file][rank] == ' ' ||
        move_coords[0] != 0 && spaces[file][rank] != ' ')
      if mock_move(king_coords, piece_coords, destination, spaces)
        return piece_coords
      end
    elsif move_coords[0] != 0 && spaces[file][rank] == ' '
      if legal_en_passant?([king_coords, destination, piece_coords],
                            spaces, ally_piece)
        return piece_coords
      end
    end
    return nil
  end
  
  def legal_en_passant?(coords, spaces, ally_piece)
    king_coords = coords[0]
    destination = coords[1]
    piece_coords = coords[2]

    legality = false
    coord_change = []
    coord_change << destination[0] - piece_coords[0]
    coord_change << destination[1] - piece_coords[1]

    file = destination[0]
    rank = destination[1]

    if ally_piece.en_passant?(piece_coords, coord_change, destination,
                              spaces)
      enemy_piece = spaces[file][rank + -coord_change[1]]
      spaces[file][rank + -coord_change[1]] = ' '
      legality = mock_move(king_coords, piece_coords, destination, spaces)
      spaces[file][rank + -coord_change[1]] = enemy_piece
      if legality
        unless enemy_piece.en_passant
          legality = false
        end
      end
    end
    return legality
  end

end
