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
end
