# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#referencePriceCalculation' do
  let(:symbol) { 'BNBUSDT' }
  let(:path) { "/api/v3/referencePrice/calculation?symbol=#{symbol}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client.reference_price_calculation(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return reference price calculation' do
    spot_client.reference_price_calculation(symbol: symbol)
    expect(send_a_request(:get, path)).to have_been_made
  end
end
