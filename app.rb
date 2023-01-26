# frozen_string_literal: true

require 'sinatra'
require 'erb'
require_relative 'models/calculator'

# App
class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/' do
    begin
      operands = Calculator.parse params[:operands]
    rescue CalculatorHandler::InvalidOperandError, CalculatorHandler::InsufficientOperandsError => e
      halt 400, e.message
    end

    case params[:action]
    when '+'
      @result = Calculator.sum operands
    when '-'
      @result = Calculator.subtract operands
    when '*'
      @result = Calculator.multiply operands
    end

    erb :index
  end
end
