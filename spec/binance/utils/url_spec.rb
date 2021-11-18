# frozen_string_literal: true

RSpec.describe Binance::Utils::Url do
  context 'encode url' do
    it 'return encoded url' do
      expect(described_class.build_query({ 'foo': 'bar' })).to eq('foo=bar')
    end
  end

  context 'with array' do
    it 'return flat encoding' do
      expect(described_class.build_query({ 'foo': %w[bar baz] })).to eq('foo=bar&foo=baz')
    end
  end

  context 'mixed with array' do
    it 'return flat encoding' do
      expect(described_class.build_query({ 'foo': %w[bar baz], 'key': 'value' })).to eq('foo=bar&foo=baz&key=value')
    end
  end

  context 'unencode email symbol' do
    it 'return unencode email symbol' do
      expect(described_class.build_query({ email: 'alice@test.com' })).to eq('email=alice@test.com')
    end
  end

  context 'add a parameter to the query string' do
    it 'return add a param to nil' do
      expect(described_class.add_param(nil, 'key', 'value')).to eq('key=value')
    end

    it 'return add a param to empty string' do
      expect(described_class.add_param('', 'key', 'value')).to eq('key=value')
    end

    it 'return add a param to empty string' do
      expect(described_class.add_param('key=value', 'key2', 'value2')).to eq('key=value&key2=value2')
    end
  end
end
