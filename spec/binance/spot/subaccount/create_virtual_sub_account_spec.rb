# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#create_virtual_sub_account' do
  let(:path) { '/sapi/v1/sub-account/virtualSubAccount' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { { subAccountString: 'virtualAccount' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validate subAccountString' do
    it 'should raise validation error without subAccountString' do
      expect { spot_client_signed.create_virtual_sub_account(subAccountString: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should create virtual sub account' do
    spot_client_signed.create_virtual_sub_account(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
