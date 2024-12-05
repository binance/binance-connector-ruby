# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#convert_limit_query_open_orders' do
  let(:path) { '/sapi/v1/convert/limit/queryOpenOrders' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:post, path, status, body)
  end

  it 'should return a quote for the requested token pairs' do
    spot_client_signed.convert_limit_query_open_orders
    expect(send_a_request_with_signature(:post, path)).to have_been_made
  end
end
