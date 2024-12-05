# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#commission_rate' do
  let(:path) { '/api/v3/account/commission' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { symbol: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.commission_rate(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { symbol: 'BNBUSDT' } }
    it 'should return current account commission rates' do
      spot_client_signed.commission_rate(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
