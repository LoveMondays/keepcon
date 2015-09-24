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

    context 'when the body is empty' do
      let(:body) { '' }

      it { is_expected.to eq({}) }
    end

    context 'when the body is a sample of send data to process' do
      let(:body) do
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <response>
            <status>OK</status>
            <setId>b126-980e385130ca</setId>
          </response>
        XML
      end

      it { is_expected.to include('status' => 'OK') }
      it { is_expected.to include('setId' => 'b126-980e385130ca') }
    end

    context 'when the body is a sample of send data to process' do
      let(:body) do
        <<-XML
          <?xml version="1.0" encoding="UTF-8"?>
          <export setId="b537-35642fb84114">
            <contents>
              <content id="159407">
              <moderatorName>AutomaticModerator</moderatorName>
              <moderationDate>1440533232819</moderationDate>
              <moderationDecision>UNKNOWN</moderationDecision>
              <tagging>
                <tag>02_PercepcaoEmotiva_qualidadeDeVida_neg</tag>
                <tag>sa_Negativo</tag>
              </tagging>
              </content>
            </contents>
          </export>
        XML
      end

      it { expect(subject['setId']).to eq('b537-35642fb84114') }
    end
  end
end
