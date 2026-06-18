# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#reference_price' do
  let(:symbol) { 'BNBUSDT' }
  let(:path) { "/api/v3/referencePrice?symbol=#{symbol}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client.reference_price(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return reference price' do
    spot_client.reference_price(symbol: symbol)
    expect(send_a_request(:get, path)).to have_been_made
  end
end
