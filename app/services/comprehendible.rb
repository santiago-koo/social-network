# frozen_string_literal: true

module Comprehendible
  def client
    @client ||= Aws::Comprehend::Client.new(
      region: ENV.fetch('AWS_REGION', nil),
      access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', nil),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
    )
  end

  def dominant_language
    response = client.detect_dominant_language(text: text_to_analize).languages
    response.present? ? response.first.language_code : ''
  end
end
