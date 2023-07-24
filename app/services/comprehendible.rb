# frozen_string_literal: true

module Comprehendible
  def client
    @client ||= Aws::Comprehend::Client.new(
      region: ENV['AWS_REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )
  end

  def dominant_language
    response = client.detect_dominant_language(text: text_to_analize).languages
    response.present? ? response.first.language_code : ''
  end
end
