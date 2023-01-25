# frozen_string_literal: true

# Calculator
class Calculator
  def self.parse(operands_string)
    operands_string.split.map(&:to_f)
  end

  def self.sum(operands_array)
    operands_array.sum
  end
end
