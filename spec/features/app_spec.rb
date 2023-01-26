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
      post '/', { action: '+', operands: 'c 0 e 4' }

      expect(last_response.status).to eq(400)
    end
  end

  context 'when summing no operands' do
    it 'returns status 400' do
      post '/', { action: '+', operands: '' }

      expect(last_response.status).to eq(400)
    end
  end

  context 'when summing one operand' do
    it 'returns status 400' do
      post '/', { action: '+', operands: '1' }

      expect(last_response.status).to eq(400)
    end
  end

  context 'when summing valid operands' do
    let(:params) { { action: '+', operands: '2.5 4 2e1 0.31 2e-1 1e+1 -9' } }

    it 'returns status 200' do
      post '/', params

      expect(last_response.status).to eq(200)
    end

    it 'contains result' do
      post '/', params

      expect(last_response.body).to include('Result')
      expect(last_response.body).to include('28.01')
    end
  end

  context 'when subtracting valid operands' do
    let(:params) { { action: '-', operands: '2.5 4 2e1 0.31 2e-1 1e+1' } }

    it 'returns status 200' do
      post '/', params

      expect(last_response.status).to eq(200)
    end

    it 'contains result' do
      post '/', params

      expect(last_response.body).to include('Result')
      expect(last_response.body).to include('-32.01')
    end
  end

  context 'when multiplying valid operands' do
    let(:params) { { action: '*', operands: '2.5 4 2e1 0.31 2e-1 1e+1' } }

    it 'returns status 200' do
      post '/', params

      expect(last_response.status).to eq(200)
    end

    it 'contains result' do
      post '/', params

      expect(last_response.body).to include('Result')
      expect(last_response.body).to include('124.0')
    end
  end

  context 'when dividing zero operands' do
    context 'when zero is numerator' do
      let(:params) { { action: '/', operands: '0 65 0.12 8.5 5' } }

      it 'returns status 200' do
        post '/', params

        expect(last_response.status).to eq(200)
      end

      it 'contains result' do
        post '/', params

        expect(last_response.body).to include('Result')
        expect(last_response.body).to include('0.0')
      end
    end

    context 'when zero is denominator' do
      let(:params) { { action: '/', operands: '65 0.12 8.5 0' } }

      it 'returns status 400' do
        post '/', params

        expect(last_response.status).to eq(400)
      end
    end

    context 'when zero is divided by zero' do
      let(:params) { { action: '/', operands: '0 0.12 8.5 0' } }

      it 'returns status 400' do
        post '/', params

        expect(last_response.status).to eq(400)
      end
    end
  end
end
