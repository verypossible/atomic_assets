require 'spec_helper'

describe AtomicAssets::Initialize do
  subject { TestComponent }

  describe '.new' do
    let(:options) { { a: 1, b: 2} }
    before { allow_any_instance_of(TestComponent).to receive(:capture_block).and_return('test') }

    describe 'with hash' do
      it 'does not raise error' do
        expect { TestComponent.new(options) }.not_to raise_exception
      end
    end

    describe 'with string' do
      it 'raises error' do
        expect { TestComponent.new('test') }.to raise_exception(ArgumentError)
      end
    end

    describe 'with other object' do
      it 'raises error' do
        expect { TestComponent.new(Object.new) }.to raise_exception(ArgumentError)
      end
    end

    describe 'without block' do
      let(:instance) { TestComponent.new(options) }

      it 'assigns options' do
        expect(instance.options).to be(options)
      end

      # it 'does not capture block' do
      #   expect(instance).not_to have_received(:capture_block)
      # end
    end

    describe 'with block' do
      let(:instance) { TestComponent.new(options) { 'test' } }

      it 'captures block' do
        expect(instance).to have_received(:capture_block).once.with(options)
      end
    end
  end

  describe '#capture_block' do
    subject { TestComponent.new }
    before { allow(subject).to receive(:h).and_return(helpers) }
    let(:helpers) { double(capture: 'test') }
    let(:options) { { a: 1, b: 2} }

    it 'calls capture' do
      expect(subject).to receive(:h).once
      expect(helpers).to receive(:capture).once
      subject.send(:capture_block, options) { 'test' }
    end

    it 'changes options' do
      expect { 
        subject.send(:capture_block, options) { 'test' }
      }.to change {
        options
      }.to(a: 1, b: 2, content: 'test')
    end
  end
end
