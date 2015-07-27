require 'spec_helper'

describe AtomicAssets::Options do
  subject { OptionComponent.new(one: 'abc', two: '345') }

  describe '.option' do
    it 'defines named accessors' do
      expect(subject).to respond_to(:one)
      expect(subject.one).to eq('abc')
      expect(subject).to respond_to(:three)
      expect(subject.three).to be_nil
    end

    it 'does not define unnamed accessors' do
      expect(subject).not_to respond_to(:two)
      expect(subject.options[:two]).to eq('345')
    end

    it 'retains changes' do
      expect {
        subject.options[:one] = 'def'
      }.to change {
        subject.one
      }.to('def')
    end
  end

  describe '.option_settings' do
    it 'defaults to empty' do
      expect(TestComponent.option_settings).to be_empty
    end

    it 'stores passed settings' do
      expect(OptionComponent.option_settings).to eq(
        one: { a: 1, b: 2 }, three: { c: 5 }
      )
    end
  end

  describe '.option_keys' do
    it 'defaults to empty' do
      expect(TestComponent.option_keys).to be_empty
    end

    it 'stores passed settings' do
      expect(OptionComponent.option_keys).to eq([:one, :three])
    end
  end
end
