require 'spec_helper'

describe AtomicAssets::Serialize do
  subject { TestComponent.new(a: 1, b: 'string') }

  describe '#to_yaml' do
    it 'calls dump' do
      expect(YAML).to receive(:dump).with(subject)
      subject.to_yaml
    end

    it 'returns correct yaml' do
      yaml = "--- !ruby/object:TestComponent\noptions:\n  :a: 1\n  :b: string\n"
      expect(subject.to_yaml).to eq(yaml)
    end
  end
end
