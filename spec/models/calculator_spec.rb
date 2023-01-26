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

    context 'when string is empty' do
      let(:input_string) { '' }

      it 'raises Insufficient Operands error' do
        expect { Calculator.parse(input_string) }.to raise_error(CalculatorHandler::InsufficientOperandsError)
      end
    end

    context 'when there is only one operand' do
      let(:input_string) { '10' }

      it 'raises Insufficient Operands error' do
        expect { Calculator.parse(input_string) }.to raise_error(CalculatorHandler::InsufficientOperandsError)
      end
    end

    context 'when there is an invalid operand' do
      let(:input_string_with_letter) { '10 25 a' }
      let(:decimal_value_separated_by_comma) { '10 2,5 3.2' }
      let(:input_string_with_symbol) { '10 & !* !()' }

      it 'raises Invalid Operand Error' do
        expect { Calculator.parse(input_string_with_letter) }.to raise_error(CalculatorHandler::InvalidOperandError)
      end

      it 'raises Invalid Operand Error' do
        expect { Calculator.parse(decimal_value_separated_by_comma) }.to raise_error(CalculatorHandler::InvalidOperandError)
      end

      it 'raises Invalid Operand Error' do
        expect { Calculator.parse(input_string_with_symbol) }.to raise_error(CalculatorHandler::InvalidOperandError)
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

  describe '#subtract' do
    context 'when subtracting integers' do
      it 'subtracts two integers' do
        operands = Calculator.parse('20 35')

        result = Calculator.subtract(operands)

        expect(result).to eq(-15)
      end

      it 'subtracts a list of integers' do
        operands = Calculator.parse('20 32 -65 98 -1 25')

        result = Calculator.subtract(operands)

        expect(result).to eq(-69)
      end
    end

    context 'when subtracting floats' do
      it 'subtacts a list of floats' do
        operands = Calculator.parse('0.2 7.89 98 -0.3')

        result = Calculator.subtract(operands)

        expect(result).to eq(-105.39)
      end
    end
  end
end
