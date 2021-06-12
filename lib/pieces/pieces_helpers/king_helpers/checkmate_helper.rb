require 'pry'

module CheckmateHelper

  private

  def get_check_paths(king_coords, spaces, board)
    paths = []

    @checked_by.each do |piece|
      piece_coords = board.get_piece_coords(piece)

      file = king_coords[0] - piece_coords[0]
      rank = king_coords[1] - piece_coords[1]
      coord_diff = [file, rank]

      if piece.class.name == 'Bishop' || piece.class.name == 'Queen'
        unless coord_diff[0] == 0 || coord_diff[1] == 0
          path = piece.get_diagonal_moves(coord_diff, piece_coords,
                                          king_coords, spaces)
          paths += [piece_coords] + path
        end
      end

      if piece.class.name == 'Rook' || piece.class.name == 'Queen'
        if coord_diff[0] == 0 || coord_diff[1] == 0
          path = piece.get_horiz_vert_moves(coord_diff, piece_coords,
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
        space = spaces[file][rank]

        if space == ' '
          unless enemy_paths.include?([file, rank])
            if mock_move(king_coords, nil, [file, rank], spaces)
              legal_king_moves << [file, rank]
            end
          end
        elsif enemy_paths.include?([file, rank])
          if mock_move(king_coords, nil, [file, rank], spaces)
            legal_king_moves << [file, rank]
          end
        end
      end
    end
    return legal_king_moves
  end

  def get_legal_move_list(king_coords, board, enemy_paths)
    spaces = board.spaces
    ally_moves = get_moves()
    legal_moves = []

    enemy_paths.each do |enemy_coords|
      ally_moves.each do |move_type, move_set|
        move_set.each do |move_coords|

          case move_type
          when :rook_moves
            piece = get_vert_horiz_piece(enemy_coords, move_coords, spaces)
            legal_move = get_legal_vert_horiz_moves([king_coords, enemy_coords],
                                                     board, piece)
            legal_move == nil ? nil : legal_moves << legal_move
          when :bishop_moves
            piece = get_diagonal_piece(enemy_coords, move_coords, spaces)
            legal_move = get_legal_diag_moves([king_coords, enemy_coords],
                                               board, piece)
            legal_move == nil ? nil : legal_moves << legal_move
          when :knight_moves
            piece = get_knight(enemy_coords, move_coords, spaces)
            legal_move = get_legal_knight_moves([king_coords, enemy_coords],
                                                 board, piece)
            legal_move == nil ? nil : legal_moves << legal_move
          when :pawn_moves
            legal_move = get_legal_pawn_moves(king_coords, enemy_coords,
                                               move_coords, spaces)
            legal_move == nil ? nil : legal_moves << legal_move
          end
        end
      end
    end
    return legal_moves
  end

  def get_legal_vert_horiz_moves(coords, board, piece)
    king_coords = coords[0]
    enemy_coords = coords[1]

    spaces = board.spaces
    piece_coords = board.get_piece_coords(piece)

    if piece != nil && piece.color == @color
      if mock_move(king_coords, piece_coords, enemy_coords, spaces)
        if piece.class.name == 'Rook' || piece.class.name == 'Queen'
          return piece_coords
        else
          return nil
        end
      end
    end
  end

  def get_legal_diag_moves(coords, board, piece)
    king_coords = coords[0]
    enemy_coords = coords[1]

    spaces = board.spaces
    piece_coords = board.get_piece_coords(piece)

    if piece != nil && piece.color == @color
      if mock_move(king_coords, piece_coords, enemy_coords, spaces)
        if piece.class.name == 'Bishop' ||piece.class.name == 'Queen'
          return piece_coords
        else
          return nil
        end
      end
    end
  end

  def get_legal_knight_moves(coords, board, piece)
    king_coords = coords[0]
    enemy_coords = coords[1]

    spaces = board.spaces
    piece_coords = board.get_piece_coords(piece)

    if mock_move(king_coords, piece_coords, enemy_coords, spaces)
      if piece.class.name == 'Knight'
        return piece_coords
      else
        return nil
      end
    end
  end

  def get_legal_pawn_moves(king_coords, enemy_coords, move_coords, spaces)
    piece_coords = []
    piece_coords << enemy_coords[0] + move_coords[0]
    piece_coords << enemy_coords[1] + move_coords[1]

    unless spaces[piece_coords[0]] == nil
      piece = spaces[piece_coords[0]][piece_coords[1]]
    end

    if mock_move(king_coords, piece_coords, enemy_coords, spaces)
      file = enemy_coords[0]
      rank = enemy_coords[1]
      if (move_coords[0] == 0 && spaces[file][rank] == ' ' ||
          move_coords[0] != 0 && spaces[file][rank] != ' ')
        unless @color == 'white' && rank < 0 || @color == 'black' && rank > 0
          if piece.class.name == 'Pawn'
            return piece_coords
          else
            return nil
          end
        end
      end
    end
  end

  def mock_move(king_coords, piece_coords, piece_move, spaces)
    return false if king_coords == piece_coords
    move_legality = false

    piece_coords == nil ? file = king_coords[0] : file = piece_coords[0]
    piece_coords == nil ? rank = king_coords[1] : rank = piece_coords[1]

    destination = spaces[piece_move[0]][piece_move[1]]
    piece = spaces[file][rank]
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

end
