# frozen_string_literal: true

RSpec.describe Binance::Utils::Validation do
  context '#require_param' do
    context 'should fail validation' do
      where(:param) do
        [nil, '', [], {}]
      end
      with_them do
        it 'should raise RequiredParameterError' do
          expect { described_class.require_param('param_name', param) }.to raise_error(Binance::RequiredParameterError)
        end
      end
    end

    context 'should pass validation' do
      where(:param) do
        ['bar', 0, 1, [1, 2, 3], { foo: 'bar' }, true, false]
      end
      with_them do
        it 'should not raise RequiredParameterError' do
          expect { described_class.require_param('param_name', param) }.not_to raise_error(Binance::RequiredParameterError)
        end
      end
    end
  end

  context '#invalid?' do
    context 'should be invalid' do
      where(:param) do
        [nil, '', [], {}]
      end
      with_them do
        it 'should return true' do
          expect(described_class.invalid?(param)).to be true
        end
      end
    end

    context 'should be valid' do
      where(:param) do
        ['bar', 0, 1, [1, 2, 3], { foo: 'bar' }, true, false]
      end
      with_them do
        it 'should return false' do
          expect(described_class.invalid?(param)).to be false
        end
      end
    end
  end
end
