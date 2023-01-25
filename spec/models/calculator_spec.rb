# frozen_string_literal: true

require_relative '../spec_helper'

describe Calculator do
  describe '#parse' do
    let(:input_string) { '15 20 32 56 89 45' }

    it 'returns an array' do
      operands = Calculator.parse(input_string)

      expect(operands.class.name).to eq('Array')
    end
  end

  describe '#sum' do
    context 'when summing integers' do
      it 'sums two positive integers' do
        operands = Calculator.parse('5 15')

        result = Calculator.sum(operands)

        expect(result).to eq(20)
      end

      it 'sums negative and positive integers' do
        operands = Calculator.parse('-5 15')

        result = Calculator.sum(operands)

        expect(result).to eq(10)
      end

      it 'sums negative integers' do
        operands = Calculator.parse('-5 -9')

        result = Calculator.sum(operands)

        expect(result).to eq(-14)
      end

      it 'sums five integers' do
        operands = Calculator.parse('10 5 10 32 -9')

        result = Calculator.sum(operands)

        expect(result).to eq(48)
      end
    end

    context 'when summing floats' do
      it 'sums two positive floats' do
        operands = Calculator.parse('5.2 10')

        result = Calculator.sum(operands)

        expect(result).to eq(15.2)
      end

      it 'sums two positive floats' do
        operands = Calculator.parse('5.2 10.0')

        result = Calculator.sum(operands)

        expect(result).to eq(15.2)
      end

      it 'sums two negative floats' do
        operands = Calculator.parse('-1.3 -9.0')

        result = Calculator.sum(operands)

        expect(result).to eq(-10.3)
      end
    end
  end
end
