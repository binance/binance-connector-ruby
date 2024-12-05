# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#margin_leverage_bracket' do
  let(:path) { '/sapi/v1/margin/leverageBracket' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:get, path, status, body)
  end

  it 'should return liability coin leverage bracket in Cross Margin Pro Mode' do
    spot_client_signed.margin_leverage_bracket
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end
end
