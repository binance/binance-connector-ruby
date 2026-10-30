# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::DCI, '#dual_investment_products' do
  let(:path) { '/sapi/v1/dci/product/list' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { optionType: '', exercisedCoin: 'USDT', investCoin: 'BTC' },
        { optionType: 'CALL', exercisedCoin: '', investCoin: 'BTC' },
        { optionType: 'CALL', exercisedCoin: 'USDT', investCoin: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.dual_investment_products(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with mandatory params' do
    let(:params) { { optionType: 'CALL', exercisedCoin: 'USDT', investCoin: 'BTC' } }

    it 'should return dual investment product list' do
      spot_client_signed.dual_investment_products(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end

  context 'with optional params' do
    let(:params) do
      {
        optionType: 'PUT',
        exercisedCoin: 'BTC',
        investCoin: 'USDT',
        pageSize: 10,
        pageIndex: 1,
        recvWindow: 10_000
      }
    end

    it 'should return dual investment product list' do
      spot_client_signed.dual_investment_products(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
