# frozen_string_literal: true

# Calculator Erros
class CalculatorHandler
  # Invalid Operand Error
  class InvalidOperandError < StandardError
    def message
      'Invalid operand(s)'
    end
  end

  # Insufficient Operands Error
  class InsufficientOperandsError < StandardError
    def message
      'At least two operands are required'
    end
  end
end
