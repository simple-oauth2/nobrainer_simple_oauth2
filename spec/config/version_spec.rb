require 'spec_helper'

describe 'NoBrainer::Simlpe::OAuth2 Version' do
  context 'has a version string' do
    it { expect(NoBrainer::Simple::OAuth2::VERSION::STRING).to be_present }
  end

  context 'returns version as an instance of Gem::Version' do
    it { expect(NoBrainer::Simple::OAuth2.gem_version).to be_an_instance_of(Gem::Version) }
  end
end
