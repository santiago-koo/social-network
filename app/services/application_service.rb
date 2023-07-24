# frozen_string_literal: true

module ApplicationService
  def return_message(success, data = nil, error = nil)
    OpenStruct.new({ success?: success, data: data, error: error})
  end

  def log_errors(error)
    Rails.logger.error error.message
    Rails.logger.error error.backtrace.join("\n")
    return_message(false, nil, error.message)
  end
end
