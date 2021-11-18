# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Futures, '#futures_account_transfer' do
  let(:path) { '/sapi/v1/futures/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { asset: '', amount: 1, type: 1 },
        { asset: 'BUSD', amount: '', type: 1 },
        { asset: 'BUSD', amount: 1, type: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.futures_account_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { asset: 'BUSD', amount: 1, type: 1 } }
    it 'should do transfer' do
      spot_client_signed.futures_account_transfer(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
