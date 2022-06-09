# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Futures, '#repay_with_collateral' do
  let(:path) { '/sapi/v1/futures/loan/collateralRepay' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    let(:params) { { quoteId: '' } }
    it 'should raise validation error without mandatory params' do
      expect { spot_client_signed.repay_with_collateral(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with params' do
    let(:params) { { quoteId: 'quote_id' } }
    it 'should repay' do
      spot_client_signed.repay_with_collateral(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
