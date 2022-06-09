# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#convert_trade_flow' do
  let(:path) { '/sapi/v1/convert/tradeFlow' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { startTime: '', endTime: 1_646_096_461_000 },
        { startTime: 1_643_504_461_000, endTime: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.convert_trade_flow(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { startTime: 1_643_504_461_000, endTime: 1_646_096_461_000 } }
    it 'should return payment history' do
      spot_client_signed.convert_trade_flow(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
