# frozen_string_literal: true

class Session < Binance::Session
  attr_reader :base_url, :proxy_url, :headers, :auth, :logger, :show_weight_usage, :show_header, :timeout
end

RSpec.describe Binance::Session do
  context 'should init' do
    where(:options, :expected_options) do
      [
        [{ base_url: 'base_url' }, { base_url: 'base_url', auth: Binance::Authentication.new(nil, nil), show_weight_usage: false, show_header: false, timeout: nil }],
        [{ base_url: 'base_url', proxy_url: 'proxy_url' }, { base_url: 'base_url', proxy_url: 'proxy_url', auth: Binance::Authentication.new(nil, nil), show_weight_usage: false, show_header: false, timeout: nil }],
        [{ key: 'key', secret: 'secret' }, { base_url: 'https://api.binance.com', auth: Binance::Authentication.new('key', 'secret'), show_weight_usage: false, show_header: false, timeout: nil }],
        [{ show_weight_usage: true }, { base_url: 'https://api.binance.com', auth: Binance::Authentication.new(nil, nil), show_weight_usage: true, show_header: false, timeout: nil }],
        [{ show_header: true }, { base_url: 'https://api.binance.com', auth: Binance::Authentication.new(nil, nil), show_weight_usage: false, show_header: true, timeout: nil }],
        [{ timeout: 10 }, { base_url: 'https://api.binance.com', auth: Binance::Authentication.new(nil, nil), show_weight_usage: false, show_header: false, timeout: 10 }]
      ]
    end
    with_them do
      subject { Session.new(options) }
      it 'include the updated options' do
        expect(subject.base_url).to eq(expected_options[:base_url])
        expect(subject.proxy_url).to eq(expected_options[:proxy_url])
        expect(subject.auth.key).to eq(expected_options[:auth].key)
        expect(subject.auth.secret).to eq(expected_options[:auth].secret)
        expect(subject.logger).to eq(nil)
        expect(subject.show_weight_usage).to eq(expected_options[:show_weight_usage])
        expect(subject.show_header).to eq(expected_options[:show_header])
        expect(subject.timeout).to eq(expected_options[:timeout])
      end
    end
  end

  context 'should init logger' do
    subject { Session.new({ logger: Logger.new($stdout) }) }
    it 'include the updated options' do
      expect(subject.base_url).to eq('https://api.binance.com')
      expect(subject.proxy_url).to eq(nil)
      expect(subject.auth.key).to eq(nil)
      expect(subject.auth.secret).to eq(nil)
      expect(subject.logger).to be_a(Logger)
      expect(subject.show_weight_usage).to eq(false)
      expect(subject.show_header).to eq(false)
      expect(subject.timeout).to eq(nil)
    end
  end

  context 'when init with proxy' do
    before do
      allow(Faraday).to receive(:new).with(url: 'https://api.binance.com', proxy: 'proxy_url')
    end

    subject { Session.new(proxy_url: 'proxy_url' ) }
    it 'include the proxy options' do
      subject.send(:build_connection)
      expect(Faraday).to have_received(:new).with(url: 'https://api.binance.com', proxy: 'proxy_url')
    end
  end

  context 'when init without proxy' do
    before do
      allow(Faraday).to receive(:new).with(url: 'https://api.binance.com')
    end

    subject { Session.new( url: 'test') }
    it 'not include the proxy options' do
      subject.send(:build_connection)
      expect(Faraday).to have_received(:new).with(url: 'https://api.binance.com')
    end
  end
end
