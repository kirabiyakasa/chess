class Player
  attr_reader :name, :color, :pieces

  def initialize(colors, player_num)
    @name = get_name(player_num)
    @color = choose_color(colors)
  end

  private

  def get_name(player_num)
    puts "\nEnter a name for #{player_num}."
    name = gets.chomp
    return name
  end

  def choose_color(colors)
    if colors.length == 2
      puts "\nSelect a Color for #{@name}."
      puts "\n1) Black    2) White"
      answer = gets.chomp
      until answer == '1' || answer == '2'
        puts 'Please Enter a valid input.'
        answer = gets.chomp
      end
      answer == '1' ? color = colors.shift : color = colors.pop
    else
      color = colors.pop
    end
    return color
  end

end
