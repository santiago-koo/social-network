# frozen_string_literal: true

module ApplicationService
  Result = Struct.new(:success?, :data, :error, keyword_init: true)
  private_constant :Result

  def return_message(success, data = nil, error = nil)
    Result.new({ success?: success, data:, error: })
  end

  def log_errors(error)
    Rails.logger.error error.message
    Rails.logger.error error.backtrace.join("\n")
    return_message(false, nil, error.message)
  end
end
