require 'spec_helper'

describe AtomicAssets::Render do
  subject { TestComponent.new(a: 1, b: 'string') }

  describe 'COMPONENT_PATH' do
    it 'has default value' do
      expect(AtomicAssets::Render::COMPONENT_PATH).to eq('components')
    end
  end

  describe 'PARTIALS_DEPRECATED' do
    it 'has default value' do
      expect(AtomicAssets::Render::PARTIALS_DEPRECATED).to be_a(String)
    end
  end

  describe '#html_safe?' do
    it 'is true' do
      expect(subject.html_safe?).to eq(true)
    end
  end

  describe '#render' do
    before { allow(subject).to receive(:component_name).and_return('test') }
    before { allow(subject).to receive(:render_partial).and_return(:render_part) }
    before { allow(subject).to receive(:render_template).and_return(:render_temp) }

    describe 'existing template' do

      it 'renders template' do
        expect(subject).to receive(:render_template).once
        expect(subject).not_to receive(:render_partial)
        expect(subject.render).to eq(:render_temp)
      end
    end

    describe 'missing template' do
      let(:error) { ActionView::MissingTemplate.new([], 'test', [], false, '') }
      before { allow(subject).to receive(:render_template).and_raise(error) }

      it 'renders partial' do
        expect(subject).to receive(:render_template).once
        expect(subject).to receive(:render_partial).once
        expect(subject.render).to eq(:render_part)
      end
    end

    describe 'missing different template' do
      let(:error) { ActionView::MissingTemplate.new([], 'other', [], false, '') }
      before { allow(subject).to receive(:render_template).and_raise(error) }

      it 'raises exception' do
        expect(subject).to receive(:render_template).once
        expect(subject).not_to receive(:render_partial)
        expect { subject.render }.to raise_error(ActionView::MissingTemplate)
      end
    end
  end

  describe '#render_options' do
    context 'no options' do
      subject { TestComponent.new }
      it { expect(subject.render_options).to be_empty }
    end

    context 'predefined options' do
      subject { OptionComponent.new }
      it { expect(subject.render_options).to eq(one: nil, three: nil) }
    end

    context 'supplied options' do
      subject { TestComponent.new(two: 'something') }
      it { expect(subject.render_options).to eq(two: 'something') }
    end

    context 'combined options' do
      subject { OptionComponent.new(two: 'something') }
      it { expect(subject.render_options).to eq(one: nil, two: 'something', three: nil) }
    end
  end

  describe '#template_path' do
    before { allow(subject).to receive(:component_name).and_return('xyz') }

    it 'concatenates path to view' do
      expect(subject.template_path).to eq('components/xyz')
    end
  end

  describe '#to_s' do
    it 'calls render' do
      expect(subject).to receive(:render).once.and_return(:render_test)
      expect(subject.to_s).to eq(:render_test)
    end
  end

  # private methods

  describe '#component_name' do
    it 'returns suffixless class name' do
      expect(subject.send(:component_name)).to eq('test')
    end
  end

  describe '#render_partial' do
    let(:h) { double(render: :render_test) }
    let(:render_opts) { { partial: 'x/y', locals: { a: 1, b: 'string', options: { a: 1, b: 'string' } }, formats: [:html] } }
    before { allow(subject).to receive(:h).and_return(h) }
    before { allow(subject).to receive(:template_path).and_return('x/y') }

    it 'renders partial' do
      expect(subject).to receive(:h).once
      expect(subject).to receive(:template_path).once
      expect(h).to receive(:render).with(render_opts).once
      expect(ActiveSupport::Deprecation).to receive(:warn).with(AtomicAssets::Render::PARTIALS_DEPRECATED).once
      expect(subject.send(:render_partial)).to eq(:render_test)
    end
  end

  describe '#render_template' do
    let(:h) { double(render: :render_test) }
    let(:render_opts) { { template: 'x/y', locals: { a: 1, b: 'string', options: { a: 1, b: 'string' } }, formats: [:html] } }
    before { allow(subject).to receive(:h).and_return(h) }
    before { allow(subject).to receive(:template_path).and_return('x/y') }

    it 'renders template' do
      expect(subject).to receive(:h).once
      expect(subject).to receive(:template_path).once
      expect(h).to receive(:render).with(render_opts).once
      expect(subject.send(:render_template)).to eq(:render_test)
    end
  end
end
