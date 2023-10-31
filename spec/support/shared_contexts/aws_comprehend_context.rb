# frozen_string_literal: true

RSpec.shared_context 'detect_language' do |default_language|
  before do
    allow(client).to receive(:detect_dominant_language).with(text:).and_return(dominant_language)
  end

  let(:language_code) do
    if default_language.nil?
      'en'
    else
      default_language
    end
  end
  let(:dominant_language) { OpenStruct.new(languages:) }
  let(:languages) { [OpenStruct.new(language_code:, score: 0.943865180015564)] }
end

RSpec.shared_context 'detect_sentiment' do |sentiment, positive, negative, neutral, mixed|
  let(:detect_sentiment) { OpenStruct.new(sentiment:, sentiment_score:) }
  let(:sentiment_score) { OpenStruct.new(positive:, negative:, neutral:, mixed:) }
end
