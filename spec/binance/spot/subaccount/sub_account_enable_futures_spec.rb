# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_enable_futures' do
  let(:path) { '/sapi/v1/sub-account/futures/enable' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      email: 'alice@test.com'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation email' do
    it 'should raise validation error without email' do
      expect { spot_client_signed.sub_account_enable_futures(email: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return assets' do
    spot_client_signed.sub_account_enable_futures(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
