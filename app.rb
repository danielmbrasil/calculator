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
      case params[:action]
      when '+'
        @result = Calculator.sum params[:operands]
      when '*'
        @result = Calculator.multiply params[:operands]
      end
    rescue CalculatorHandler::InvalidOperandError, CalculatorHandler::InsufficientOperandsError => e
      halt 400, e.message
    end

    erb :index
  end
end
