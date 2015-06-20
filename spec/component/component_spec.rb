require 'spec_helper'

describe AtomicAssets::Component do
  it 'is a decorator' do
    expect(subject).to be_a(Draper::Decorator)
  end

  it 'includes Deserialize' do
    expect(subject).to be_an(AtomicAssets::Deserialize)
  end

  it 'includes Serialize' do
    expect(subject).to be_an(AtomicAssets::Serialize)
  end
end
