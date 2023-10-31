# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AwsComprehend::Sentiment do
  before do
    allow(Aws::Comprehend::Client).to receive(:new).with(region: instance_of(String),
                                                         access_key_id: instance_of(String), secret_access_key: instance_of(String)).and_return(client)
  end

  let(:service) { described_class.new(text).execute }
  let(:client) { double(Aws::Comprehend::Client) }

  describe '#execute' do
    context 'when the language code exists in the laguage code list' do
      include_context 'detect_language'

      before do
        allow(client).to receive(:detect_sentiment).with(text: instance_of(String),
                                                         language_code: instance_of(String)).and_return(detect_sentiment)
      end

      context 'detect sentiment when the text is neutral' do
        include_context 'detect_sentiment', 'NEUTRAL', 0.020090490579605103, 0.002232613507658243, 0.9776280522346497,
                        4.888398325419985e-05

        let(:text) { 'Hello world!' }

        it 'returns recommended setiment with their respective scrores' do
          expect(service.success?).to be(true)
          expect(service.data[:recommended_sentiment]).to eq('NEUTRAL')
        end
      end

      context 'detect sentiment when the text is positive' do
        include_context 'detect_sentiment', 'POSITIVE', 0.9776280522346497, 0.002232613507658243, 0.020090490579605103,
                        4.888398325419985e-05

        let(:text) { 'I love it' }

        it 'returns recommended setiment with their respective scrores' do
          expect(service.success?).to be(true)
          expect(service.data[:recommended_sentiment]).to eq('POSITIVE')
        end
      end

      context 'detect sentiment when the text is negative' do
        include_context 'detect_sentiment', 'NEGATIVE', 0.002232613507658243, 0.9776280522346497, 0.020090490579605103,
                        4.888398325419985e-05

        let(:text) { 'I hate it' }

        it 'returns recommended setiment with their respective scrores' do
          expect(service.success?).to be(true)
          expect(service.data[:recommended_sentiment]).to eq('NEGATIVE')
        end
      end

      context 'detect sentiment when the text is mixed' do
        include_context 'detect_sentiment', 'MIXED', 0.002232613507658243, 4.888398325419985e-05, 0.020090490579605103,
                        0.9776280522346497

        let(:text) { 'I hate you, but you are my love' }

        it 'returns recommended setiment with their respective scrores' do
          expect(service.success?).to be(true)
          expect(service.data[:recommended_sentiment]).to eq('MIXED')
        end
      end
    end

    context 'when the language code does not exists in the laguage code list' do
      # 'ro' means Romanian
      include_context 'detect_language', 'ro'

      before do
        allow(client).to receive(:detect_sentiment).with(text: instance_of(String),
                                                         language_code: instance_of(String)).and_raise(Aws::Comprehend::Errors::ValidationException.new(
                                                                                                         nil, exception_message
                                                                                                       ))
      end

      let(:text) { 'I hate you, but you are my love' }
      let(:exception_message) do
        "Value 'ro' at 'languageCode'failed to satisfy constraint: Member must satisfy enum value set: [ar, hi, ko, zh-TW, ja, zh, de, pt, en, it, fr, es]"
      end

      it 'returns recommended setiment with their respective scrores' do
        expect(service.success?).to be(false)
        expect(service[:error]).to eq(exception_message)
      end
    end
  end
end
