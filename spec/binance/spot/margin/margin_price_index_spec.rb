# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_price_index' do
  let(:path) { '/sapi/v1/margin/priceIndex' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:symbol) { 'BNB' }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation symbol' do
    let(:params) { { symbol: '' } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.margin_price_index(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:path) { "/sapi/v1/margin/priceIndex?symbol=#{symbol}" }
    it 'should query margin priced index' do
      spot_client_signed.margin_price_index(symbol: symbol)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
