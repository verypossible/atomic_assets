require 'spec_helper'

describe AtomicAssets::Deserialize do
  subject { AtomicAssets::Component }

  let(:component) { TestComponent.new(a: 1, b: 'string') }
  let(:yaml) { "--- !ruby/object:TestComponent\noptions:\n  :a: 1\n  :b: string\n" }

  describe '.from_yaml' do
    it 'calls preload_components' do
      expect(subject).to receive(:preload_components).once.with(yaml)
      subject.from_yaml(yaml)
    end

    it 'calls YAML.load' do
      expect(YAML).to receive(:load).once.with(yaml)
      subject.from_yaml(yaml)
    end

    it 'deserializes object' do
      obj = subject.from_yaml(yaml)
      expect(obj).to be_a(TestComponent)
      expect(obj.options).to eq(component.options)
    end
  end

  describe '.preload_components' do
    it 'constantizes classes from yaml' do
      expect(subject.send(:preload_components, yaml)).to eq([TestComponent])
    end
  end
end
