# frozen_string_literal: true

module AwsComprehend
  class Sentiment
    include ::ApplicationService
    include ::Comprehendible

    attr_reader :text_to_analize

    def initialize(text_to_analize)
      @text_to_analize = text_to_analize
    end

    def execute
      return_message(true, result)
    rescue Aws::Comprehend::Errors::ValidationException => e
      log_errors(e)
      return_message(false, {}, e.message)
    end

    private

    def response
      @response ||= client.detect_sentiment(text: text_to_analize, language_code: dominant_language)
    end

    def result
      sentiment_score = response.sentiment_score

      {
        recommended_sentiment: response.sentiment,
        positive_score: sentiment_score.positive,
        negative_score: sentiment_score.negative,
        neutral_score: sentiment_score.neutral,
        mixed_score: sentiment_score.mixed
      }
    end
  end
end
