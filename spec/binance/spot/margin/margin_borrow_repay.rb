# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#margin_borrow_repay' do
  let(:path) { '/sapi/v1/margin/borrow-repay' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { asset: '', isIsolated: 'TRUE', symbol: 'BNBUSDT', amount: '1.0', type: 'BORROW' },
        { asset: 'BNB', isIsolated: '', symbol: 'BNBUSDT', amount: '1.0', type: 'BORROW' },
        { asset: 'BNB', isIsolated: 'TRUE', symbol: '', amount: '1.0', type: 'BORROW' },
        { asset: 'BNB', isIsolated: 'TRUE', symbol: 'BNBUSDT', amount: '', type: 'BORROW' },
        { asset: 'BNB', isIsolated: 'TRUE', symbol: 'BNBUSDT', amount: '1.0', type: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.margin_borrow_repay(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { asset: 'BNB', isIsolated: 'TRUE', symbol: 'BNBUSDT', amount: '1.0', type: 'BORROW' } }
    it 'should return borrow/repay records in Margin account' do
      spot_client_signed.margin_borrow_repay(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
