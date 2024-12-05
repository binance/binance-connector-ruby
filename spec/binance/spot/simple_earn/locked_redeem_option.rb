# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#locked_redeem_option' do
  let(:path) { '/sapi/v1/simple-earn/locked/setRedeemOption' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { positionId: '', redeemTo: 'SPOT' },
        { positionId: '1234', redeemTo: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.locked_redeem_option(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { positionId: '1234', redeemTo: 'SPOT' } }
    it 'should set redeem option for Locked product' do
      spot_client_signed.locked_redeem_option(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
