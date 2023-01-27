# frozen_string_literal: true

require_relative '../spec_helper'

describe Calculator do
  describe '#sum' do
    context 'when input is valid' do
      context 'when input contains only integer numbers' do
        let(:input) { '20 15 32 18 +1000 95 -9 1e1 10e-1' }

        it 'it adds up numbers correctly' do
          result = Calculator.sum(input)

          expect(result).to eq(1182)
        end
      end

      context 'when input contains only float numbers' do
        let(:input) { '2.0 .15 -.32 +18.2 +.1e-1 +9.5 -9.75 1e-1' }

        it 'it adds up numbers correctly' do
          result = Calculator.sum(input)

          expect(result).to eq(19.89)
        end
      end

      context 'when input contains integer and float numbers' do
        let(:input) { '20 15 32 18 +1000 95 -9 10e-1 -0.32 +18.2 +9.5 -9.75 1e-1' }

        it 'it adds up numbers correctly' do
          result = Calculator.sum(input)

          expect(result).to eq(1189.73)
        end
      end
    end

    context 'when input is invalid' do
      context 'when input uses comma as decimal separator' do
        let(:input) { '15 1e5 10,2' }

        it 'raises InvalidOperandError' do
          expect { Calculator.sum(input) }.to raise_error(CalculatorHandler::InvalidOperandError)
        end
      end

      context 'when input is empty' do
        let(:input) { '' }

        it 'raises InsufficientOperandsError' do
          expect { Calculator.sum(input) }.to raise_error(CalculatorHandler::InsufficientOperandsError)
        end
      end

      context 'when input contains only one operand' do
        let(:input) { '1' }

        it 'raises InsufficientOperandsError' do
          expect { Calculator.sum(input) }.to raise_error(CalculatorHandler::InsufficientOperandsError)
        end
      end

      context 'when input contains letters' do
        let(:input) { '1.0 +1 2e a' }

        it 'raises InvalidOperandError' do
          expect { Calculator.sum(input) }.to raise_error(CalculatorHandler::InvalidOperandError)
        end
      end

      context 'when input contains special characters' do
        let(:input) { '1.0 +1 5% 2!' }

        it 'raises InvalidOperandError' do
          expect { Calculator.sum(input) }.to raise_error(CalculatorHandler::InvalidOperandError)
        end
      end

      context 'when input values are separated by comma' do
        let(:input) { '1.0,4.5,9,1e1' }

        it 'raises InsufficientOperandsError' do
          expect { Calculator.sum(input) }.to raise_error(CalculatorHandler::InsufficientOperandsError)
        end
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

  describe '#multiply' do
    it 'multiplies a list of integers' do
      operands = Calculator.parse('2 5 1 8 9 10')

      result = Calculator.multiply(operands)

      expect(result).to eq(7_200)
    end

    it 'multiplies a list of floats' do
      operands = Calculator.parse('2.2 0.5e1 -1.3 8 9e-1 10.1')

      result = Calculator.multiply(operands)

      expect(result).to eq(-1039.896)
    end
  end
end
