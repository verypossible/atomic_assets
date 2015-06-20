require 'spec_helper'

describe AtomicAssets::Helper do
  subject { Class.new { include AtomicAssets::Helper }.new }

  describe '#component' do
    let(:component_class) { double(new: :new_component) }
    before { allow(subject).to receive(:component_class).and_return(component_class) }

    it 'initializes named component' do
      expect(subject).to receive(:component_class).with(:test).once
      expect(component_class).to receive(:new).with(a: 1).once
      expect(subject.component(:test, a: 1)).to eq(:new_component)
    end
  end

  describe '#component_class' do
    describe 'with existing component' do
      it 'returns class constant' do
        expect(subject.send(:component_class, :test)).to be(TestComponent)
      end
    end

    describe 'with missing component' do
      it 'raises error' do
        expect { subject.send(:component_class, :fake) }.to raise_error(NameError)
      end
    end
  end
end
