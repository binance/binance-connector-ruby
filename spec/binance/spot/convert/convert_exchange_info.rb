# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#convert_exchange_info' do
  let(:path) { '/sapi/v1/convert/exchangeInfo' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return all convertible token pairs and the tokens respective upper/lower limits' do
    spot_client_signed.convert_exchange_info(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
