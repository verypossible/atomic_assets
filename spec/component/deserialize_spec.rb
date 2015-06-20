require 'spec_helper'

describe AtomicAssets::Deserialize do
  subject { AtomicAssets::Component }

  let(:component) { TestComponent.new(a: 1, b: 'string') }
  let(:yaml) { "--- !ruby/object:TestComponent\nobject:\n  :a: 1\n  :b: string\ncontext: {}\n" }

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
      expect(subject.from_yaml(yaml)).to eq(component)
    end
  end

  describe '.preload_components' do
    it 'constantizes classes from yaml' do
      expect(subject.send(:preload_components, yaml)).to eq([TestComponent])
    end
  end
end
