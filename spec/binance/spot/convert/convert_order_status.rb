# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#convert_order_status' do
  let(:path) { '/sapi/v1/convert/orderStatus' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should retrieve convert trade history' do
    spot_client_signed.convert_order_status
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
