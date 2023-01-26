# frozen_string_literal: true

require_relative 'errors/calculator_handler'

# Calculator
class Calculator
  VALID_NUMBER_REGEX = /\A((\+|-)?\d*\.?\d+)([eE](\+|-)?\d+)?\z/.freeze

  def self.parse(operands_string)
    operands_array = operands_string.split

    raise CalculatorHandler::InsufficientOperandsError if operands_array.empty? || operands_array.size < 2

    operands_array.map do |operand|
      raise CalculatorHandler::InvalidOperandError unless operand.match?(VALID_NUMBER_REGEX)

      operand.to_f
    end
  end

  def self.sum(operands_array)
    operands_array.sum
  end
end
