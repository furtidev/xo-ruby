class Game
    # game board
    @@board = ["-", "-", "-","-", "-", "-", "-","-", "-"]
    @@game_is_running = true
    @@current_player = "X"
    @@winner = nil

    def input(text=" ")
        puts text
        return gets
    end

    def init_game()
        print "~~~~~\n"
        display_board()
        while @@game_is_running
            input_handler(@@current_player)
            check_gameover
            flip_player
        end

        if @@winner == "X" or @@winner == "Y"
            print "#{@@winner} won!\n"
        end
    end

    # What is a graphics library?
    def display_board()
        print "--------\n"
        print "|#{@@board[0]}|#{@@board[1]}|#{@@board[2]}|\n|#{@@board[3]}|#{@@board[4]}|#{@@board[5]}|\n|#{@@board[6]}|#{@@board[7]}|#{@@board[8]}|"
        print "\n--------"
    end

    def input_handler(player)
        print "\n#{player}'s turn\n"
        position = input("Choose Position (1-9): ")

        valid = false
        while !valid
            while !position.to_i.between?(1,9)
                position = input("Invalid. Choose Position (1-9): ")
            end

            position = (position.to_i - 1)

            if @@board[position] == "-"
                print "~~~~~\n"
                valid = true
            else
                print "✗ This spot is already filled. Choose another one. \n"
            end
        end
        @@board[position] = player
        display_board()
    end

    def check_gameover()
        check_winner
        check_tie
    end

    def check_winner()
        row = check_row
        column = check_column
        diagonal = check_diagonal

        if row != nil
            @@winner = row
        elsif column != nil
            @@winner = column
        elsif diagonal != nil
            @@winner = diagonal
        else
            @@winner = nil
        end
    end

    def check_row()
        row_1 = @@board[0] == @@board[1] && @@board[1] == @@board[2] && @@board[2] != "-"
        row_2 = @@board[3] == @@board[4] && @@board[4] == @@board[5] && @@board[5] != "-"
        row_3 = @@board[6] == @@board[7] && @@board[7] == @@board[8] && @@board[8] != "-"

        if row_1 or row_2 or row_3
            @@game_is_running = false
        end
        if row_1
            return @@board[0]
        elsif row_2
            return @@board[3]
        elsif row_3
            return @@board[6]
        else
            return nil
        end
    end
    
    def check_column()
        col_1 = @@board[0] == @@board[3] && @@board[3] == @@board[6] && @@board[6] != "-"
        col_2 = @@board[1] == @@board[4] && @@board[4] == @@board[7] && @@board[7] != "-"
        col_3 = @@board[2] == @@board[5] && @@board[5] == @@board[8] && @@board[8] != "-"

        if col_1 or col_2 or col_3
            @@game_is_running = false
        end
        if col_1
            return @@board[0]
        elsif col_2
            return @@board[1]
        elsif col_3
            return @@board[2]
        else
            return nil
        end
    end

    def check_diagonal()
        diag_1 = @@board[0] == @@board[4] && @@board[4] == @@board[8] && @@board[8] != "-"
        diag_2 = @@board[2] == @@board[4] && @@board[4] == @@board[6] && @@board[6] != "-"

        if diag_1 or diag_2
            @@game_is_running = false
        end

        if diag_1
            return @@board[0]
        elsif diag_2
            return @@board[2]
        else
            return nil
        end
    end

    def check_tie()
        if !@@board.include? "-"
            @@game_is_running = false
            return true
        else
            return false
        end
    end

    def flip_player()
        if @@current_player == "X"
            @@current_player = "O"
        elsif @@current_player == "O"
            @@current_player = "X"
        end
    end
end

game = Game.new
game.init_game