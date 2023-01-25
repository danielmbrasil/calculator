# frozen_string_literal: true

require_relative '../spec_helper'

describe Calculator do
  describe '#parse' do
    context 'when parsing' do
      let(:input_string) { '15 20 32 56 89 45' }

      it 'returns an array' do
        operands = Calculator.parse(input_string)

        expected_result = [15.0, 20.0, 32.0, 56.0, 89.0, 45.0]

        expect(operands).to eq(expected_result)
      end
    end

    context 'when there are negative numbers' do
      let(:input_string) { '-15 20 -32 -56 89 -54' }

      it 'returns an array' do
        operands = Calculator.parse(input_string)

        expected_result = [-15.0, 20.0, -32.0, -56.0, 89.0, -54.0]

        expect(operands).to eq(expected_result)
      end
    end

    context 'when there are numbers with decimal places' do
      let(:input_string) { '15.2 -10.0 9.1 3.5 7.8 -0.2 0.0 -0.75' }

      it 'returns an array' do
        operands = Calculator.parse(input_string)

        expected_result = [15.2, -10.0, 9.1, 3.5, 7.8, -0.2, 0.0, -0.75]

        expect(operands).to eq(expected_result)
      end
    end

    context 'when there are numbers with exponential notation' do
      let(:input_string) { '1.25e3 1 -8.4 0.2e1 -8.45e5 1000e0 1e1' }

      it 'returns an array' do
        operands = Calculator.parse(input_string)

        expected_result = [1_250.0, 1.0, -8.4, 2.0, -845_000.0, 1_000.0, 10.0]

        expect(operands).to eq(expected_result)
      end
    end

    context 'when there are numbers with exponential notation and negative exponent' do
      let(:input_string) { '1.25e-3 1e-4 -8.4 0.2e1 -8.45e-5 1000e-0 1e1' }

      it 'returns an array' do
        operands = Calculator.parse(input_string)

        expected_result = [0.00125, 0.0001, -8.4, 2.0, -8.45e-5, 1_000.0, 10.0]

        expect(operands).to eq(expected_result)
      end
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
