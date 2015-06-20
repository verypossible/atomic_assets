require 'spec_helper'

describe AtomicAssets::Render do
  subject { TestComponent.new(a: 1, b: 'string') }

  describe 'COMPONENT_PATH' do
    it 'has default value' do
      expect(AtomicAssets::Render::COMPONENT_PATH).to eq('components')
    end
  end

  describe '#render' do
    let(:h) { double(render: :render_test) }
    before { allow(subject).to receive(:h).and_return(h) }
    before { allow(subject).to receive(:template_path).and_return('x/y') }

    it 'renders partial' do
      expect(subject).to receive(:h).once
      expect(h).to receive(:render).with(partial: 'x/y', locals: { options: { a: 1, b: 'string' } }).once
      expect(subject.render).to eq(:render_test)
    end
  end

  describe '#to_s' do
    it 'calls render' do
      expect(subject).to receive(:render).once.and_return(:render_test)
      expect(subject.to_s).to eq(:render_test)
    end
  end

  describe '#component_name' do
    it 'returns suffixless class name' do
      expect(subject.send(:component_name)).to eq('test')
    end
  end

  describe '#template_path' do
    before { allow(subject).to receive(:component_name).and_return('xyz') }

    it 'concatenates path to view' do
      expect(subject.send(:template_path)).to eq('components/xyz')
    end
  end
end
