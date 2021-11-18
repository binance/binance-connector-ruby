# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Blvt, '#token_info' do
  let(:tokenName) { 'BTCUP' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'with params' do
    let(:path) { "/sapi/v1/blvt/tokenInfo?tokenName=#{tokenName}" }
    it 'should return token info' do
      spot_client_signed.token_info(tokenName: tokenName)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
