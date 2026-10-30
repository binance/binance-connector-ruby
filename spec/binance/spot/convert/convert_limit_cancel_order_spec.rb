# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#convert_limit_cancel_order' do
  let(:path) { '/sapi/v1/convert/limit/cancelOrder' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { orderId: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.convert_limit_cancel_order(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { orderId: '1234' } }
    it 'should cancel a limit order' do
      spot_client_signed.convert_limit_cancel_order(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
