require 'spec_helper'

describe Keepcon::Entity::Response do
  describe '.new' do
    subject { described_class.new(response) }

    let(:response) { Faraday::Response.new.finish(status: 200, body: 'ok') }

    it { expect(subject.status).to eq(200) }
    it { expect(subject.body).to eq('ok') }
  end
end
