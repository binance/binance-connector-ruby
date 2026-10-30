# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#executionRules' do
  let(:symbol) { 'BNBUSDT' }
  let(:path) { "/api/v3/executionRules?symbol=#{symbol}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  it 'should return execution rules' do
    spot_client.execution_rules(symbol: symbol)
    expect(send_a_request(:get, path)).to have_been_made
  end
end
