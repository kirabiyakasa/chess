require './lib/board_builder.rb'

class Board
  attr_reader :p1, :p2, :white_king, :black_king, :spaces

  def initialize(player1, player2)
    @p1 = player1
    @p2 = player2
    board_builder = BoardBuilder.new
    @spaces = board_builder.build_board
    @white_king = @spaces[4][0]
    @black_king = @spaces[4][7]
  end

  def move_piece(interface, player, king)
    start_coords = select_piece(interface, player)
    end_coords = false

    while end_coords == false || ['save', 'cancel'].include?(end_coords)
      if start_coords == 'save' || end_coords == 'save'
        return 'save'
      end
      end_coords = select_destination(interface, player, start_coords, king)
      if end_coords == 'cancel'
        start_coords = select_piece(interface, player)
      end
    end
    move_resolved = resolve_move(start_coords, end_coords, interface)
    return move_resolved
  end

  def get_piece_coords(piece)
    x = nil
    y = nil

    @spaces.keys.each do |column|
      if @spaces[column].include?(piece)
        x = column
        y = @spaces[column].find_index(piece)
        return [x, y]
      end
    end
  end

  private

  def get_coordinates(interface, type)
    interface.ask_for_file(type)
    file = gets.chomp
    until ('a'..'h').include?(file.downcase) || file == 'y' || file == 's'
      interface.show_invalid_input
      interface.ask_for_file(type)
      file = gets.chomp
    end
    if file == 'y'
      return 'cancel'
    elsif file == 's'
      return 'save'
    end
    file = convert_file(file.downcase).to_i

    interface.ask_for_rank(type)
    rank = gets.chomp
    until ('1'..'8').include?(rank) || rank == 'y' || rank == 's'
      interface.show_invalid_input
      interface.ask_for_rank(type)
      rank = gets.chomp
    end
    if rank == 'y'
      return 'cancel'
    elsif rank == 's'
      return 'save'
    end

    rank = rank.to_i - 1
    return [file, rank]
  end

  def get_space(coords)
    return nil if coords == 'cancel' || coords == 'save'
    rank = coords[0]
    file = coords[1]
    space = @spaces[rank][file]
    return space
  end

  def select_piece(interface, player)
    interface.show_piece_select
    start_coords = get_coordinates(interface, 'piece')
    piece = nil

    piece = get_space(start_coords)

    while piece == ' ' || piece == nil || player.color != piece.color
      if start_coords == 'cancel'
        interface.show_canceled_move_input
      elsif start_coords == 'save'
        return 'save'
      else
        interface.show_invalid_selection(start_coords)
      end
      start_coords = get_coordinates(interface, 'piece')
      piece = get_space(start_coords)
    end
    return start_coords
  end

  def select_destination(interface, player, start_coords, king)
    interface.show_destination_select
    end_coords = get_coordinates(interface, 'destination')

    move_legality = false
    while [false, 'checked'].include?(move_legality) || end_coords == 'cancel'
      if end_coords == 'cancel'
        return 'cancel'
      else
        move_legality = legal_move?(start_coords, end_coords)
      end

      if move_legality == true
        king_coords = get_piece_coords(king)
        unless king_coords == start_coords
          if king.mock_move(king_coords, start_coords, end_coords, @spaces)
            move_legality = true
          else
            move_legality = 'checked'
          end
        end
      end

      if move_legality == false
        interface.show_invalid_destination
        end_coords = get_coordinates(interface, 'destination')
      elsif move_legality == 'checked'
        if @black_king.checked_by.any? || @white_king.checked_by.any?
          interface.show_escape_check
        else
          interface.show_move_into_check
        end
        end_coords = get_coordinates(interface, 'destination')
      end
    end
    return end_coords
  end

  def legal_move?(start_coords, end_coords)
    rank = start_coords[0]
    file = start_coords[1]
    start_piece = @spaces[rank][file]
    
    legality = start_piece.check_legal_move(start_coords, end_coords, @spaces)
    return legality
  end

  def resolve_move(start_coords, end_coords, interface)
    start_file = start_coords[0]
    start_rank = start_coords[1]
    piece = @spaces[start_file][start_rank]

    if piece.class.name == 'Pawn'
      if piece.promote_pawn?(end_coords)
        piece = promote_pawn(interface, piece.color)
      end
    end

    end_file = end_coords[0]
    end_rank = end_coords[1]

    @spaces[end_file][end_rank] = piece
    @spaces[start_file][start_rank] = ' '
    return true
  end

  def promote_pawn(interface, color)
    interface.show_pawn_promotion()
    input = gets.chomp
    until (1..4).include?(input.to_i)
      puts 'Invalid input. Enter a number 1-4'
      input = gets.chomp
    end
    selection = input.to_i
    piece = nil

    case selection
    when 1
      piece = Queen.new(color)
    when 2
      piece = Bishop.new(color)
    when 3
      piece = Knight.new(color)
    when 4
      piece = Rook.new(color)
    end
    return piece
  end

  def convert_file(file)
    file_letters = ("a".."h").to_a
    if file_letters.include?(file)
      file = file_letters.find_index(file).to_s
      return file
    else
      return nil
    end
  end

end
