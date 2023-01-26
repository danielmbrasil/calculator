# frozen_string_literal: true

require_relative '../spec_helper'

describe App do
  def app
    App
  end

  context 'when loading index' do
    it 'returns status 200' do
      get '/'

      expect(last_response.status).to eq(200)
    end
  end

  context 'when summing invalid operands' do
    it 'returns status 400' do
      post '/', { operands: 'c 0 e 4' }

      expect(last_response.status).to eq(400)
    end
  end

  context 'when summing no operands' do
    it 'returns status 400' do
      post '/', { operands: '' }

      expect(last_response.status).to eq(400)
    end
  end

  context 'when summing one operand' do
    it 'returns status 400' do
      post '/', { operands: '1' }

      expect(last_response.status).to eq(400)
    end
  end

  context 'when summing valid operands' do
    let(:param_string) { '2.5 4 2e1 0.31 2e-1 1e+1 -9' }

    it 'returns status 200' do
      post '/', { operands: param_string }

      expect(last_response.status).to eq(200)
    end

    it 'contains result' do
      post '/', { operands: param_string }

      expect(last_response.body).to include('Result')
      expect(last_response.body).to include('28.01')
    end
  end
end
