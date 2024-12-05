# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#one_click_arrival_deposit_apply' do
  let(:path) { '/sapi/v1/capital/deposit/credit-apply' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_sign_request(:post, path, status, body)
  end

  it 'should apply deposit credit for expired address' do
    spot_client_signed.one_click_arrival_deposit_apply
    expect(send_a_request_with_signature(:post, path)).to have_been_made
  end
end
