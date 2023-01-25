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
    operands = Calculator.parse params[:operands]
    @result = Calculator.sum operands
    erb :index
  end
end
