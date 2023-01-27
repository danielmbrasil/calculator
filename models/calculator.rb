# frozen_string_literal: true

require_relative 'errors/calculator_handler'

# Calculator
class Calculator
  VALID_NUMBER_REGEX = /\A((\+|-)?\d*\.?\d+)([eE](\+|-)?\d+)?\z/.freeze
  MINIMUM_OPERANDS_NUMBER = 2

  def self.sum(operands)
    parse(operands).sum
  end

  def self.multiply(operands)
    parse(operands).inject(:*)
  end

  def self.divide(operands)
    operands = parse(operands)

    validate_denominators(operands[1..])

    operands.inject(:/)
  end

  def self.parse(operands_string)
    operands_array = operands_string.split

    validate_operands(operands_array)

    operands_array.map(&:to_f)
  end

  def self.validate_operands(operands)
    raise CalculatorHandler::InsufficientOperandsError if operands.empty? || operands.size < MINIMUM_OPERANDS_NUMBER

    raise CalculatorHandler::InvalidOperandError unless operands.all? { |operand| operand.match?(VALID_NUMBER_REGEX) }
  end

  def self.validate_denominators(denominators)
    raise ZeroDivisionError if denominators.any?(&:zero?)
  end

  private_class_method :parse, :validate_operands, :validate_denominators
end
