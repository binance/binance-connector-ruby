# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#my_filters' do
  let(:path) { '/api/v3/myFilters' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { { symbol: 'BNBUSDT' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.my_filters(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return my filters' do
    spot_client_signed.my_filters(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
