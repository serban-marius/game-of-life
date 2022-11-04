# typed: true

require 'sorbet-runtime'

class Board
  extend T::Sig

  sig {returns(Integer)}
  attr_accessor :rows
  sig {returns(Integer)}
  attr_accessor :columns
  sig {returns(T::Array[T::Array[T::Boolean]])}
  attr_accessor :board

  alias :show_board :board

  sig do
    params(
      rows: Integer,
      columns: Integer,
      board: T::Array[T::Array[T::Boolean]]
    ).void
  end
  def initialize(rows, columns, board)
    @rows = rows
    @columns = columns
    @board = board
  end

  sig { void }
  def next_generation

  end
end