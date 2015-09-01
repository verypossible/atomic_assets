require 'spec_helper'

describe AtomicAssets::Component do
  it 'extends Draper::ViewHelpers' do
    expect(subject).to be_a(Draper::ViewHelpers)
  end

  it 'includes Deserialize' do
    expect(subject).to be_an(AtomicAssets::Deserialize)
  end

  it 'includes Helper' do
    expect(subject).to be_an(AtomicAssets::Helper)
  end

  it 'includes Initialize' do
    expect(subject).to be_an(AtomicAssets::Initialize)
  end

  it 'includes Options' do
    expect(subject).to be_an(AtomicAssets::Options)
  end

  it 'includes Render' do
    expect(subject).to be_an(AtomicAssets::Render)
  end

  it 'includes Serialize' do
    expect(subject).to be_an(AtomicAssets::Serialize)
  end
end
