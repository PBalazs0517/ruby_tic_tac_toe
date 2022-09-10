# Cells class, it has nine instencies, each representing a tile displayed in the terminal when played 
class Cells
    attr_reader :cellId
    attr_accessor :cellCharacter, :used

    @@array_of_cells = []

    def initialize(cellId)
        @cellId = cellId
        @used = false
        @cellCharacter = " "
    end

    def self.array_of_cells()
        @@array_of_cells
    end

    def self.array_of_cells=(newCell)
        @@array_of_cells.push(newCell)
    end

    def self.index_of_cell_based_on_cellId?(cellId)
        i = 0
        while i < 9 do
            if cellId == @@array_of_cells[i].cellId    
               break
            end
            i += 1
        end
        return i
    end
end

# Rounds class, used to manage rounds  
class Rounds 
    
    @@player_turn = 1
    @@filled_cells = 0

    def self.print_board()
        puts ""
        puts ""
        puts "                          1   2   3 "
        puts "                       a  #{Cells.array_of_cells[0].cellCharacter} | #{Cells.array_of_cells[1].cellCharacter} | #{Cells.array_of_cells[2].cellCharacter} "
        puts "                         ----------- "
        puts "                       b  #{Cells.array_of_cells[3].cellCharacter} | #{Cells.array_of_cells[4].cellCharacter} | #{Cells.array_of_cells[5].cellCharacter} "
        puts "                         ----------- "
        puts "                       c  #{Cells.array_of_cells[6].cellCharacter} | #{Cells.array_of_cells[7].cellCharacter} | #{Cells.array_of_cells[8].cellCharacter} "
        puts ""
        puts ""
    end

    def self.play()

        Rounds.print_board()

        # checks which player's turn is it
        player = nil
        if @@player_turn == 1
            print "     Player 1's move: "
            player = 1
            @@player_turn = 2
        else 
            print "     Player 2's move: "
            player = 2
            @@player_turn = 1
        end

        # gets the player's move
        move = gets.chomp.downcase

        # if the pleyer entered a wrong format than this runs to reenter the move
        until move.length == 2 && ['a', 'b', 'c'].any? { |letter| letter == move[0] } && ['1', '2', '3'].any? { |num| num == move[1] }
            print "     Sorry you entered a wrong format. Please enter a new move: "
            move = gets.chomp.downcase
            puts ""
        end

        # gets the selected cell's index to make it easier to use  
        selected_cell_index = Cells.index_of_cell_based_on_cellId?(move)

        # if the cell that the player selected is already used than this runs to enter a new move 
        until !Cells.array_of_cells[selected_cell_index].used   
            print "     Sorry this cell is already used. Please enter a new move: "
            move = gets.chomp.downcase
            puts ""

            # if the pleyer entered a wrong format than this runs to reenter the move
            until move.length == 2 && ['a', 'b', 'c'].any? { |letter| letter == move[0] } && ['1', '2', '3'].any? { |num| num == move[1] }
                print "     Sorry you entered a wrong format. Please enter a new move: "
                move = gets.chomp.downcase
                puts ""
            end
            selected_cell_index = Cells.index_of_cell_based_on_cellId?(move)
        end

        # sets the values for the selected cell
        Cells.array_of_cells[selected_cell_index].used = true
        if player == 1
            Cells.array_of_cells[selected_cell_index].cellCharacter = "o"
        else
            Cells.array_of_cells[selected_cell_index].cellCharacter = "x"
        end

        # keeps track of how many cells are filled 
        @@filled_cells += 1

        # check for 3 in a rows
        ["a", "b", "c"].each do |letter| 
            if Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}1")].used && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}2")].used && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}3")].used
                if Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}1")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}2")].cellCharacter &&  Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}1")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}3")].cellCharacter && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}2")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("#{letter}3")].cellCharacter
                    puts "     #{player} wins!!!"
                    return
                end
            end
        end

        # check for 3 in a columns
        ["1", "2", "3"].each do |num| 
            if Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a#{num}")].used && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b#{num}")].used && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c#{num}")].used
                if Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a#{num}")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b#{num}")].cellCharacter &&  Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a#{num}")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c#{num}")].cellCharacter && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b#{num}")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c#{num}")].cellCharacter
                    puts "     #{player} wins!!!"
                    return
                end
            end
        end

        # check for 3 in a diagonals
        if Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a1")].used && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b2")].used && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c3")].used
            if Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a1")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b2")].cellCharacter &&  Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a1")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c3")].cellCharacter && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b2")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c3")].cellCharacter
                Rounds.print_board()
                puts "     #{player} wins!!!"
                puts ""
                return
            end
        end
        if Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a3")].used && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b2")].used && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c1")].used
            if Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a3")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b2")].cellCharacter &&  Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("a3")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c1")].cellCharacter && Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("b2")].cellCharacter == Cells.array_of_cells[Cells.index_of_cell_based_on_cellId?("c1")].cellCharacter
                Rounds.print_board()
                puts "     #{player} wins!!!"
                puts ""
                return
            end
        end
        # line 92 & 102 & 109-121 is pretty ugly and I'm sure there is a better way but right now I can't think of anything better, but I'll work on it after the project is fully done

        # if there is no 3 in a row but all cell is filled than its a draw and the game ends
        if @@filled_cells == 9
            Rounds.print_board()
            puts "     All cell is filled and there is no 3 in a row. It's a draw."
            puts ""
            return
        end

        # starts the next round
        Rounds.play()
    end

end

# creates cells 
i = 0; 
while i < 9 do 
    if i < 3  
      cell = Cells.new("a#{i + 1}")
    elsif i < 6  
        cell = Cells.new("b#{i - 2}")
    elsif i < 9
        cell = Cells.new("c#{i - 5}")
    end    
    Cells.array_of_cells = cell
    i += 1
end

# starting point
puts ""
puts "     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
puts ""
puts "     The game has started!!!"
puts ""
puts "     Player 1 is 'o' and Player 2 is 'x'!"
puts ""
puts "     Player 1 is the first to make a move by typing the letter" 
puts "     of the row than the number of the column (ex.: b3)."

# Starts the game
Rounds.play()