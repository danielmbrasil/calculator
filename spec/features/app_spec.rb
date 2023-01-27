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

    it 'contains expected result' do
      post '/', params

      expect(last_response.body).to include('Result')
      expect(last_response.body).to include('28.01')
    end
  end

  context 'when multiplying valid operands' do
    let(:params) { { action: '*', operands: '2.5 4 2e1 0.31 2e-1 1e+1' } }

    it 'returns status 200' do
      post '/', params

      expect(last_response.status).to eq(200)
    end

    it 'contains expected result' do
      post '/', params

      expect(last_response.body).to include('Result')
      expect(last_response.body).to include('124.0')
    end
  end

  context 'when multiplying invalid operands' do
    context 'when operands use comma as decimal separator' do
      let(:params) { { action: '*', operands: '2,5 4 2e1 0,31 2e-1 1e+1' } }

      it 'returns status 400' do
        post '/', params

        expect(last_response.status).to eq(400)
      end

      it 'contains invalid operands error message' do
        post '/', params

        expect(last_response.body).to include('Invalid operand(s)')
      end
    end

    context 'when no operands' do
      let(:params) { { action: '*', operands: '' } }

      it 'returns status 400' do
        post '/', params

        expect(last_response.status).to eq(400)
      end
    end
  end

  context 'when dividing valid operands' do
    let(:params) { { action: '/', operands: '1000 20' } }

    it 'returns status 200' do
      post '/', params

      expect(last_response.status).to eq(200)
    end

    it 'contains expected result' do
      post '/', params

      expect(last_response.body).to include('Result')
      expect(last_response.body).to include('50.0')
    end
  end

  context 'when dividing invalid operands' do
    context 'when operands use comma as decimal separator' do
      let(:params) { { action: '/', operands: '50,5 5' } }

      it 'returns status 400' do
        post '/', params

        expect(last_response.status).to eq(400)
      end

      it 'contains invalid operands error message' do
        post '/', params

        expect(last_response.body).to include('Invalid operand(s)')
      end
    end

    context 'when no operands' do
      let(:params) { { action: '/', operands: '' } }

      it 'returns status 400' do
        post '/', params

        expect(last_response.status).to eq(400)
      end
    end
  end
end
