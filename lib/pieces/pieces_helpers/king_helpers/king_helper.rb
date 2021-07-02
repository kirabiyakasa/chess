require 'pry'

module KingHelper

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

  # add castling
end
