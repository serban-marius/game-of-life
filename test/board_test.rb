require 'minitest/autorun'
require_relative '../src/board'

describe Board do
  let(:rows) { 3 }
  let(:columns) { 3 }
  let(:board) {
    [
      [true, false, false],
      [false, false, true],
      [false, true, true]
    ]
  }

  describe 'when asking for the game board' do
    it 'must respond with the game board' do
      @board = Board.new(rows, columns, board)
      _(@board.show_board).must_equal board
    end
  end

  describe 'when one generation is executed' do
    describe 'alive cells with less than two neighbours' do
      let(:expected_board) {
        [
          [false, false, false],
          [false, false, true],
          [false, true, true]
        ]
      }

      before do
        @board = Board.new(rows, columns, board)
        @board.next_generation
      end

      it 'must die' do
        _(@board.show_board).must_equal expected_board
      end
    end
  end
end
