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
      describe 'after one generation' do
        before do
          @board = Board.new(rows, columns, board)
          @board.next_generation
        end

        it 'must die' do
          _(@board.show_board[0][0]).must_equal false
        end
      end
    end

    describe 'alive cells with more than three neighbours' do
      describe 'after one generation' do
        let(:board) {
          [
            [true, false, false],
            [false, true, true],
            [false, true, true]
          ]
        }

        before do
          @board = Board.new(rows, columns, board)
          @board.next_generation
        end

        it 'must die' do
          _(@board.show_board[1][1]).must_equal false
        end
      end
    end

    describe 'alive cells with more two or three neighbours' do
      describe 'after one generation' do
        let(:board) {
          [
            [true, true, true],
            [true, true, false],
            [false, false, false]
          ]
        }

        before do
          @board = Board.new(rows, columns, board)
          @board.next_generation
        end

        it 'stay alive' do
          _(@board.show_board[0][0]).must_equal true
          _(@board.show_board[0][2]).must_equal true
        end
      end
    end

    describe 'death cells with exactly three neighbours' do
      describe 'after one generation' do
        before do
          @board = Board.new(rows, columns, board)
          @board.next_generation
        end

        it 'become alive' do
          _(@board.show_board[1][1]).must_equal true
        end
      end
    end
  end
end
