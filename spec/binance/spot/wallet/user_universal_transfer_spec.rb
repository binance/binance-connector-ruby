# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#user_universal_transfer' do
  let(:path) { '/sapi/v1/asset/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { type: '', asset: 'BUSD', amount: 1 },
        { type: 'MAIN_MARGIN', asset: '', amount: 1 },
        { type: 'MAIN_MARGIN', asset: 'BUSD', amount: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.user_universal_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { type: 'MAIN_MARGIN', asset: 'BUSD', amount: 1 } }
    it 'should transfer' do
      spot_client_signed.user_universal_transfer(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
