# typed: true

require 'sorbet-runtime'

class Board
  extend T::Sig

  attr_accessor :board

  sig { returns(Integer) }
  attr_accessor :rows

  sig { returns(Integer) }
  attr_accessor :columns

  alias :show_board :board

  sig { params(rows: Integer, columns: Integer, board: T::Array[T::Array[T::Boolean]]).void }
  def initialize(rows, columns, board)
    @rows = rows - 1
    @columns = columns - 1
    @board = board
  end

  sig { void }
  def next_generation
    future_board = []

    (0..rows).each do |row|
      future_board[row] = [] if future_board[row].nil?
      (0..columns).each do |column|
        future_board[row][column] = resuscitate?(row, column)
        if is_alive?(row, column)
          future_board[row][column] = stays_alive?(row, column)
        end
      end
    end

    @board = future_board
  end

  private

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def is_alive?(row, column)
    board[row][column]
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def stays_alive?(row, column)
    neighbours_count = how_many_neighbours(row, column)
    return false if underpopulation?(neighbours_count)
    return false if overcrowding?(neighbours_count)
    true
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def resuscitate?(row, column)
    return true if goodly_neighbours?(how_many_neighbours(row, column))
    false
  end

  sig { params(neighbours_count: Integer).returns(T::Boolean) }
  def underpopulation?(neighbours_count)
    neighbours_count < 2
  end

  sig { params(neighbours_count: Integer).returns(T::Boolean) }
  def overcrowding?(neighbours_count)
    neighbours_count > 3
  end

  sig { params(neighbours_count: Integer).returns(T::Boolean) }
  def goodly_neighbours?(neighbours_count)
    neighbours_count.equal?(3)
  end

  sig { params(row: Integer, column: Integer).returns(Integer) }
  def how_many_neighbours(row, column)
    neighbours = 0
    neighbours += 1 if upper_left(row, column)
    neighbours += 1 if upper(row, column)
    neighbours += 1 if upper_right(row, column)
    neighbours += 1 if left(row, column)
    neighbours += 1 if right(row, column)
    neighbours += 1 if bottom_left(row, column)
    neighbours += 1 if bottom(row, column)
    neighbours += 1 if bottom_right(row, column)

    neighbours
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def upper_left(row, column)
    return false unless can_go_up?(row) && can_go_left?(column)

    board[go_up(row)][go_left(column)]
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def upper(row, column)
    return false unless can_go_up?(row)

    board[go_up(row)][column]
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def upper_right(row, column)
    return false unless can_go_up?(row) && can_go_right?(column)

    board[go_up(row)][go_right(column)]
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def left(row, column)
    return false unless can_go_left?(column)

    board[row][go_left(column)]
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def right(row, column)
    return false unless can_go_right?(column)

    board[row][go_right(column)]
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def bottom_left(row, column)
    return false unless can_go_down?(row) && can_go_left?(column)

    board[go_down(row)][go_left(column)]
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def bottom(row, column)
    return false unless can_go_down?(row)

    board[go_down(row)][column]
  end

  sig { params(row: Integer, column: Integer).returns(T::Boolean) }
  def bottom_right(row, column)
    return false unless can_go_down?(row) && can_go_right?(column)

    board[go_down(row)][go_right(column)]
  end

  sig { params(row: Integer).returns(T::Boolean) }
  def can_go_up?(row)
    go_up(row) >= 0
  end

  sig { params(row: Integer).returns(T::Boolean) }
  def can_go_down?(row)
    go_down(row) <= rows
  end

  sig { params(column: Integer).returns(T::Boolean) }
  def can_go_left?(column)
    go_left(column) >= 0
  end

  sig { params(column: Integer).returns(T::Boolean) }
  def can_go_right?(column)
    go_right(column) <= columns
  end

  sig { params(row: Integer).returns(Integer) }
  def go_up(row)
    row - 1
  end

  sig { params(row: Integer).returns(Integer) }
  def go_down(row)
    row + 1
  end

  sig { params(column: Integer).returns(Integer) }
  def go_left(column)
    column - 1
  end

  sig { params(column: Integer).returns(Integer) }
  def go_right(column)
    column + 1
  end
end
