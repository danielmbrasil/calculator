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

    @result = Calculator.sum operands
    erb :index
  end
end
