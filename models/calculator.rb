# frozen_string_literal: true

require_relative 'errors/calculator_handler'

# Calculator
class Calculator
  VALID_NUMBER_REGEX = /\A((\+|-)?\d*\.?\d+)([eE](\+|-)?\d+)?\z/.freeze

  def self.parse(operands_string)
    raise CalculatorHandler::InsufficientOperandsError if operands_string.empty?
    raise CalculatorHandler::InsufficientOperandsError if operands_string.split.size < 2

    operands_string.split.map do |operand|
      raise CalculatorHandler::InvalidOperandError unless operand.match?(VALID_NUMBER_REGEX)

      operand.to_f
    end
  end

  def self.sum(operands_array)
    operands_array.sum
  end

  def self.subtract(operands_array)
    operands_array.inject(:-)
  end

  def self.multiply(operands_array)
    operands_array.inject(:*)
  end

  def self.divide(operands_array)
    operands_array.inject do |sum, n|
      raise ZeroDivisionError if n.zero?

      sum / n
    end
  end
end
