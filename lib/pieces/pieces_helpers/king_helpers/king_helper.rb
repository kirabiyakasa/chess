module KingHelper
  include PiecesHelper

  def checked?(king_coords, spaces)
    @checked_by = []
    checked_vertically_or_horizontally?(king_coords, spaces)
    checked_diagonally?(king_coords, spaces)
    checked_by_knight?(king_coords, spaces)

    if @checked_by.length > 0
      return true
    else
      return false
    end
  end

  def stalemate?(king_coords, board)
    king_moves = get_moves[:king_moves]
    legal_king_moves = get_legal_king_moves(king_coords, king_moves, board,
                                            [[king_coords[0], king_coords[1]]])
    if legal_king_moves.any?
      return false
    end

    available_pieces = get_available_pieces(board)

    if moveable_pieces?(king_coords, available_pieces, board)
      return false
    else
      return true
    end
  end

  def get_available_pieces(board)
    spaces = board.spaces
    pieces = []

    spaces.keys.each do |column|
      spaces[column].each do |space|
        unless space == ' '
          if space.color == @color
            pieces << space
          end
        end
      end
    end
    return pieces
  end

  def checkmate?(king_coords, spaces, board)
    enemy_paths = get_check_paths(king_coords, spaces, board)
    king_moves = get_moves[:king_moves]

    legal_king_moves = get_legal_king_moves(king_coords, king_moves,
                                            board, enemy_paths)
    if @checked_by.length < 2
      legal_moves = get_legal_move_list(king_coords, board, enemy_paths)
      return legal_moves + legal_king_moves
      # can move king or block with another piece
    elsif @checked_by.length > 1
      return legal_king_moves
      # can only move king
    end
  end

  def king_movement?(start_coords, coord_change, end_coords, spaces)
    if coord_change[0].abs == 2
      if castling?(start_coords, coord_change, end_coords, spaces)
        @moved = true
        return true
      end
    end
    return false unless coord_change[0].abs == 1 || coord_change[1].abs == 1
    return false if coord_change[0].abs > 1 || coord_change[1].abs > 1
    unless mock_move(start_coords, nil, end_coords, spaces)
      puts "\nMove will put king in check."
      return false
    end

    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false if destination.color == @color
    end
    @moved = true
    return true
  end

  def castling?(start_coords, coord_change, end_coords, spaces)
    return false if @moved
    king_coords = start_coords
    return false if checked?(king_coords, spaces)

    rook = nil
    coord_change[0] > 0 ? direction = 1 : direction = -1
    file = start_coords[0] += direction
    until spaces[file] == nil || spaces[file][end_coords[1]] != ' '
      # check if king is in check for first 2 spaces
      if direction.negative? && end_coords[0] - file <= 0 ||
         direction.positive? && end_coords[0] - file >= 0

        unless mock_move(king_coords, nil, [file, end_coords[1]], spaces)
          # king cannot move through or into check
          return false
        end
      end
      file += direction
    end

    if spaces[file] == nil
      return false
    else
      piece = spaces[file][end_coords[1]]
      unless piece.class.name == 'Rook' && piece.color == @color
        return false
      end
      return false if piece.moved
      rook = piece
    end

    # move the rook
    spaces[file][end_coords[1]] = ' '
    spaces[start_coords[0] + direction][start_coords[1]] = rook
    return true
  end

end
