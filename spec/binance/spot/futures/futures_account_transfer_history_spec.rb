# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Futures, '#futures_account_transfer_history' do
  let(:path) { '/sapi/v1/futures/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { asset: '', startTime: 1_555_056_425_000 },
        { asset: 'BUSD', startTime: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.futures_account_transfer_history(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { asset: 'BUSD', startTime: 1_555_056_425_000 } }
    it 'should return transfer history' do
      spot_client_signed.futures_account_transfer_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
