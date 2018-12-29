#Simple program of a tic_tac_toe game 
#written in Ruby by Charlie Hu
#28th, Dec, 2018


# Helper Methods

#possible winning combinations
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5], 
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

#display the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#convert user input into an integer
def input_to_index(user_input)
  user_input.to_i - 1
end

#handle the move operation
def move(board, index, current_player = "X")
  board[index] = current_player(board)
end

#check if a place is avali
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

#check if the move a move if valid
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

#handle turns of players
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

#count num of turns made
def turn_count(board)
  counter = 0
  board.each do |index|
    if (index == "X" or index == "O")
      counter+=1
    end
  end
  return counter
end

#check who is the current player
def current_player(board)
  return (turn_count(board).even? ? "X" : "O")
end

#check whether the game is won
def won?(board)
	if !(WIN_COMBINATIONS.any? do |indexs|
		if((indexs.all? do |values|
			board[values] == "O"
		end) or (indexs.all? do |values|
			board[values] == "X"
		end))
			return indexs
		end
	end)
		return false
	end
end

#check whether the board had been fulled
def full?(board)
  board.all? {|indexs| indexs != " "}
end

#check whether it's a cat's game
def draw?(board)
  if won?(board) == false and full?(board) == true
    return true
  elsif full?(board) == false and won?(board) == false
    return false
  elsif won?(board) == true
    return false
  end
end

#check if the board is end
def over?(board)
  if draw?(board)
    return true
  end
  if won?(board)
    return true
  end
end

#check out who's the winner
def winner(board)
  if won?(board) == false
    return nil
  else
    arra = won?(board)
    return (board[arra[0]])
  end
end

# mian function here
def play(board)
  var = 0
  while var < 9
    turn(board)
    if won?(board) != false
      arra = won?(board)
      puts "Congratulations #{winner(board)}!"
      break
    elsif draw?(board) == true
      puts "Cat's Game!"
      break
    end
    var += 1
  end
end


# bin
# !/usr/bin/env ruby
# 
# require_relative '../lib/tic_tac_toe'
# 
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

puts "Welcome to Tic Tac Toe!"

display_board(board)

play(board)
