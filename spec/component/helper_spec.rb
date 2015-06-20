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

  describe '#build_component_class' do
    it 'sets new constant' do
      expect { FakeComponent }.to raise_error(NameError)
      subject.send(:build_component_class, 'FakeComponent')
      expect(FakeComponent.new).to be_an(AtomicAssets::Component)
    end

    it 'returns new component' do
      expect(subject.send(:build_component_class, 'SomeComponent').new).to be_an(AtomicAssets::Component)
    end
  end

  describe '#component_class' do
    describe 'with existing component' do
      it 'returns class constant' do
        expect(subject.send(:component_class, :test)).to be(TestComponent)
      end
    end

    describe 'with missing component' do
      before { allow(subject).to receive(:build_component_class).and_return(:new_class)}

      it 'returns new component' do
        expect(subject).to receive(:build_component_class).once.with('AnotherComponent')
        expect(subject.send(:component_class, :another)).to eq(:new_class)
      end
    end
  end
end
