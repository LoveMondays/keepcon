require 'spec_helper'

describe Keepcon::Entity::Response do
  let(:http_response) { Faraday::Response.new.finish(status: 200, body: body) }
  let(:response) { described_class.new(http_response) }

  describe '.new' do
    subject { response }

    let(:body) { 'ok' }

    it { expect(subject.status).to eq(200) }
    it { expect(subject.body).to eq('ok') }
  end

  describe '#data' do
    subject { response.data }

    let(:set_id) { '1d523f7e-f430-46dd-b126-980e385130ca' }
    let(:body) do
      <<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <response>
          <status>OK</status>
          <setId>#{set_id}</setId>
        </response>
      XML
    end

    it { is_expected.to include('status' => 'OK') }
    it { is_expected.to include('setId' => set_id) }
  end
end
